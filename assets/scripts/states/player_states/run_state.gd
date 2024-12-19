class_name SprintState
extends PlayerState

@export var speed: float = 10.0
@export var acceleration: float = 0.1
@export var deceleration: float = 0.25

func enter(previous_state: String, state: State):
	#_animation.play("PreSprint", -1, 1.0)
	#_animation.queue("Sprint")
	
	_player.camera.set_arms_condition("run", true)
	_player.animation_tree.set("parameters/conditions/idle", true)
	_player.animation_tree.set("parameters/conditions/slide", false)


func exit(next_state: String):
	#_animation.speed_scale = 1.0
	_player.camera.set_arms_condition("run", false)


func update(delta: float):
	#_player.update_gravity(delta)
	#var _input = _player.update_input()
	#_player.update_velocity(speed, 7, delta)
	#_player.move_and_slide()
	
	#_weapon.bob(delta, speed, 0.02)
	#_weapon.mouse(delta)
	#_weapon.update(delta)
	
	var on_floor = _player.is_on_floor()
	
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
		#if Input.is_action_just_pressed("crouch"):
			#_data.push_back({
				#"pos": _player.position,
				#"normal": floor_n,
				#"axis": axis,
				#"basis": _player.floor
			#})
	else:
		_player.apply_floor_snap()
		_player.floor = Basis()
	
	_player.update_input()
	_player.update_velocity(10, 7, delta)
	_player.move_and_slide()
	
	#set_animation_speed(speed)
	
	if not _player.input:
		delegated.emit("IdleState")

	#if Input.is_action_just_released("sprint"):
		#delegated.emit("WalkState")

	#if _player.speed > 6.0:
		#match Globals.option.crouch:
			#Options.KeyMode.TOGGLE:
	#if Input.is_action_pressed("crouch") and on_floor:
		#delegated.emit("SlideState")
			#Options.KeyMode.HOLD:
				#if Input.is_action_pressed("crouch") and on_floor:
					#delegated.emit("SlideState")

	if Input.is_action_just_pressed("jump") and on_floor:
		delegated.emit("JumpState")
#
	#if _player.velocity.y < 0.0 and not on_floor:
		#delegated.emit("FallState")

	#if Input.is_action_just_pressed("main_attack"):
		#_weapon.attack()


func physics_update(delta: float):
	pass


func set_animation_speed(speed: float) -> void:
	var weight = remap(speed, 0.0, self.speed, 0.0, 1.0)
	_animation.speed_scale = weight * 3.0


#func on_attack_finished() -> void:
	#_weapon.load_pose(_weapon.walk_pose).duration(0.2)