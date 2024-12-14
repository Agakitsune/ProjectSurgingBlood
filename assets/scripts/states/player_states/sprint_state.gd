class_name SprintState
extends PlayerState

@export var speed: float = 8.0
@export var acceleration: float = 0.1
@export var deceleration: float = 0.25

var _blend: float

func enter(previous_state: String, state: State):
	#_animation.play("PreSprint", -1, 1.0)
	#_animation.queue("Sprint")
	
	_blend = _player.camera.get_arms_parameter("RunBlend/blend_amount")


func exit(next_state: String):
	_animation.speed_scale = 1.0


func update(delta: float):
	_player.update_gravity(delta)
	_player.update_input(self.speed, acceleration, deceleration)
	_player.update_velocity()
	
	if _blend < 1.0:
		_blend += delta * 5
		_player.camera.set_arms_parameter("RunBlend/blend_amount", min(_blend, 1.0))
	
	#_weapon.bob(delta, speed, 0.02)
	#_weapon.mouse(delta)
	#_weapon.update(delta)
	
	var on_floor = _player.is_on_floor()
	var speed = _player.velocity.length()
	
	set_animation_speed(speed)
	
	if speed == 0.0:
		#_animation.get_animation("ToIdle").track_set_key_value(0, 0, _player.camera.position)
		#_animation.get_animation("ToIdle").track_set_key_value(1, 0, _player.camera.rotation)
		#_animation.play("ToIdle")
		
		delegated.emit("IdleState")

	#if Input.is_action_just_released("sprint"):
		#delegated.emit("WalkState")

	if speed > 6.0:
		match Globals.option.crouch:
			Options.KeyMode.TOGGLE:
				if Input.is_action_just_pressed("crouch") and on_floor:
					delegated.emit("SlideState")
			Options.KeyMode.HOLD:
				if Input.is_action_pressed("crouch") and on_floor:
					delegated.emit("SlideState")

	if Input.is_action_just_pressed("jump") and on_floor:
		delegated.emit("JumpState")

	if _player.velocity.y < 0.0 and not on_floor:
		delegated.emit("FallState")

	#if Input.is_action_just_pressed("main_attack"):
		#_weapon.attack()


func physics_update(delta: float):
	pass


func set_animation_speed(speed: float) -> void:
	var weight = remap(speed, 0.0, self.speed, 0.0, 1.0)
	_animation.speed_scale = weight * 3.0


#func on_attack_finished() -> void:
	#_weapon.load_pose(_weapon.walk_pose).duration(0.2)
