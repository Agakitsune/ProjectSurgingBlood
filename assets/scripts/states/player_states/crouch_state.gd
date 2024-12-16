class_name CrouchState
extends PlayerState

@export var speed: float = 3.0
@export var acceleration: float = 0.1
@export var deceleration: float = 0.25
@export var crouch_speed: float = 4.0

func enter(previous_state: String, state: State):
	if previous_state == "SlideState":
		if _animation.is_playing():
			await _animation.animation_finished
		_animation.current_animation = "Crouch"
		_animation.seek(1.0, true)
		
		match Globals.option.crouch:
			Options.KeyMode.HOLD:
				if not Input.is_action_pressed("crouch"):
					uncrouch(false)
	else:
		#(_weapon.load_pose(_weapon.crouch_pose)
				#.duration(0.5)
				#.easing(Blunt.BluntEasing.BACK)
				#.easing_type(Blunt.BluntEasingType.OUT)
		#)

		_animation.play("Crouch", -1.0, crouch_speed)


func exit(next_state: String):
	pass


func update(delta: float):
	_player.update_gravity(delta)
	_player.update_input(speed, acceleration, deceleration)
	_player.update_velocity()
	
	#if _player.velocity.length_squared() == 0.0:
	#_weapon.idle(delta)
	#_weapon.update(delta)
	
	match Globals.option.crouch:
		Options.KeyMode.TOGGLE:
			if Input.is_action_just_pressed("crouch"):
				uncrouch(true)
		Options.KeyMode.HOLD:
			if Input.is_action_just_released("crouch"):
				uncrouch(false)

	#if Input.is_action_just_pressed("main_attack"):
		#_weapon.attack()


func physics_update(delta: float):
	pass


func uncrouch(toggle: bool):
	var shapecast_colliding := _shapecast.is_colliding()
	if (not Input.is_action_pressed("crouch")) or toggle:
		if not shapecast_colliding:
			if _animation.is_playing():
				await _animation.animation_finished
			_animation.play("Crouch", -1.0, -crouch_speed * 1.5, true)
			if _player.velocity.length_squared() == 0.0:
				delegated.emit("IdleState")
			else:
				delegated.emit("WalkState")
		else:
			await get_tree().create_timer(0.1).timeout
			uncrouch(toggle)


#func on_attack_finished() -> void:
	#_weapon.load_pose(_weapon.crouch_pose).duration(0.5)
