class_name IdleState
extends PlayerState

@export var speed: float = 5.0
@export var acceleration: float = 0.1
@export var deceleration: float = 0.25

var _data := []

var _jump_y: float

func enter(previous_state: String, state: State):
	#await _animation.animation_finished
	#_animation.pause()
	
	_player.camera.set_arms_condition("idle", true)
	_player.animation_tree.set("parameters/conditions/idle", true)
	_player.animation_tree.set("parameters/conditions/slide", false)


func exit(next_state: String):
	_player.camera.set_arms_condition("idle", false)


func update(delta: float):
	var on_floor = _player.is_on_floor()
	
	#for data in _data:
		#DebugDraw3D.draw_arrow(data["pos"], data["pos"] + data["normal"] * 2, Color.ORANGE, 0.1)
		#DebugDraw3D.draw_arrow(data["pos"], data["pos"] + data["axis"] * 2, Color.CYAN, 0.1)
		#
		#DebugDraw3D.draw_arrow(data["pos"], data["pos"] + data["basis"].x * 3, Color.RED, 0.1)
		#DebugDraw3D.draw_arrow(data["pos"], data["pos"] + data["basis"].y * 3, Color.GREEN, 0.1)
		#DebugDraw3D.draw_arrow(data["pos"], data["pos"] + data["basis"].z * 3, Color.BLUE, 0.1)

	_player.update_gravity(delta)
	if on_floor:
		_player.gravity_pull = 0
		var floor_n := _player.get_floor_normal()
		var axis: Vector3
		if floor_n != Vector3.UP:
			axis = floor_n.cross(Vector3.UP).normalized()
			_player.floor = Basis().rotated(axis, -_player.get_floor_angle())
		else:
			_player.floor = Basis()
		if Input.is_action_just_pressed("crouch"):
			_data.push_back({
				"pos": _player.position,
				"normal": floor_n,
				"axis": axis,
				"basis": _player.floor
			})
	else:
		_player.apply_floor_snap()
		_player.floor = Basis()
	
	_player.update_input()
	_player.update_velocity(10, 7, delta)
	_player.move_and_slide()
	
	#match Globals.option.crouch:
		#Options.KeyMode.TOGGLE:
			#if Input.is_action_just_pressed("crouch") and on_floor:
				#delegated.emit("CrouchState")
		#Options.KeyMode.HOLD:
			#if Input.is_action_pressed("crouch") and on_floor:
				#delegated.emit("CrouchState")
	
	if _player.input and on_floor:
		delegated.emit("RunState")
		#
	if Input.is_action_just_pressed("jump") and on_floor:
		delegated.emit("JumpState")

	#if Input.is_action_just_pressed("main_attack"):
		#_weapon.attack()

	#if _player.velocity.y < 0.0 and not on_floor:
		#delegated.emit("FallState")


func physics_update(delta: float):
	pass
