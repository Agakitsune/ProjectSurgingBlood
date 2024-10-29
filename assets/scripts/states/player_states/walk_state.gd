class_name WalkState
extends PlayerState

@export var speed: float = 6.0
@export var acceleration: float = 0.1
@export var deceleration: float = 0.25

func enter(previous_state: String, state: State):
	if _animation.is_playing():
		await _animation.animation_finished
	_animation.play("Walk", -1, 1.0)

	if previous_state == "CrouchState":
		_weapon.load_pose(_weapon.walk_pose).duration(0.3)
	elif previous_state != "SprintState":
		_weapon.load_pose(_weapon.walk_pose).duration(0.2)


func exit(next_state: String):
	_animation.speed_scale = 1.0


func update(delta: float):
	_player.update_gravity(delta)
	_player.update_input(speed, acceleration, deceleration)
	_player.update_velocity()
	
	#_weapon.idle(delta)
	_weapon.bob(delta, speed, 0.015)
	_weapon.mouse(delta)
	_weapon.update(delta)
	
	var speed = _player.velocity.length()
	var on_floor = _player.is_on_floor()
	
	set_animation_speed(speed)
	
	if Input.is_action_pressed("sprint") and on_floor:
		delegated.emit("SprintState")
	
	match Globals.option.crouch:
		Options.KeyMode.TOGGLE:
			if Input.is_action_just_pressed("crouch") and on_floor:
				delegated.emit("CrouchState")
		Options.KeyMode.HOLD:
			if Input.is_action_pressed("crouch") and on_floor:
				delegated.emit("CrouchState")
	
	if Input.is_action_just_pressed("jump") and on_floor:
		delegated.emit("JumpState")

	if _player.velocity.y < 0.0 and not on_floor:
		delegated.emit("FallState")

	if Input.is_action_just_pressed("main_attack"):
		_weapon.attack()

	if speed == 0.0:
		_animation.get_animation("ToIdle").track_set_key_value(0, 0, _player.camera.position.x)
		_animation.get_animation("ToIdle").track_set_key_value(1, 0, _player.camera.position.y)
		_animation.get_animation("ToIdle").track_set_key_value(2, 0, _player.camera.position.z)
		_animation.get_animation("ToIdle").track_set_key_value(3, 0, _player.camera.rotation.x)
		_animation.get_animation("ToIdle").track_set_key_value(4, 0, _player.camera.rotation.y)
		_animation.get_animation("ToIdle").track_set_key_value(5, 0, _player.camera.rotation.z)
		_animation.play("ToIdle", -1.0, 1.0)

		delegated.emit("IdleState")


func physics_update(delta: float):
	pass


func set_animation_speed(speed: float) -> void:
	var weight = remap(speed, 0.0, self.speed, 0.0, 1.0)
	_animation.speed_scale = lerp(0.0, 2.0, weight)


func on_attack_finished() -> void:
	_weapon.load_pose(_weapon.walk_pose).duration(0.2)
