class_name SlideState
extends PlayerState

@export var speed: float = 8.0
@export var acceleration: float = 0.1
@export var deceleration: float = 0.25
@export var tilt: float = 1.0

func enter(previous_state: String, state: State):
	set_tilt(_player.camera.last_rotation)
	_animation.get_animation("Slide").track_set_key_value(3, 0, _player.velocity.length())
	_animation.get_animation("Slide").track_set_key_value(3, 1, _player.velocity.length())
	_animation.speed_scale = 1.0
	_animation.play("Slide", -1.0, 4.0)
	
	#(_weapon.load_pose(_weapon.crouch_pose)
			#.duration(0.25)
			#.easing(Blunt.BluntEasing.BACK)
			#.easing_type(Blunt.BluntEasingType.OUT)
	#)



func exit(next_state: String):
	pass


func update(delta: float):
	_player.update_gravity(delta)
	_player.update_speed(speed, acceleration, deceleration)
	_player.update_velocity()
	
	#_weapon.mouse(delta)
	#_weapon.update(delta)
	
	if _player.is_on_wall():
		finish()

	if _player.velocity.y < 0.0 and not _player.is_on_floor():
		_animation.play("SlideToIdle", -1.0, 4.0)
		
		(_animation.get_animation("SlideToIdle")
				.track_set_key_value(4, 0, _player.camera.rotation)
		)
		
		delegated.emit("FallState")
	
	match Globals.option.crouch:
		Options.KeyMode.HOLD:
			if Input.is_action_just_released("crouch"):
				finish()


func physics_update(delta: float):
	pass


func set_tilt(rotation: float) -> void:
	var tilt := Vector3.ZERO
	tilt.z = clamp(tilt.z * rotation, -0.1, 0.1)
	if tilt.z == 0.0:
		tilt.z = 0.05
	_animation.get_animation("Slide").track_set_key_value(6, 1, tilt)
	_animation.get_animation("Slide").track_set_key_value(6, 2, tilt)


func finish():
	if _animation.is_playing():
		_animation.seek(5.0, true)
	
	if not _player.shapecast.is_colliding():
		_animation.play("SlideToCrouch", -1.0, 4.0)

		delegated.emit("CrouchState")
	else:
		await get_tree().create_timer(0.1).timeout
		finish()
