class_name IdleState
extends PlayerState

@export var speed: float = 5.0
@export var acceleration: float = 0.1
@export var deceleration: float = 0.25

var _blend: float

func enter(previous_state: String, state: State):
	#await _animation.animation_finished
	#_animation.pause()
	
	_blend = _player.camera.get_arms_parameter("RunBlend/blend_amount")


func exit(next_state: String):
	pass


func update(delta: float):
	_player.update_gravity(delta)
	_player.update_input(speed, acceleration, deceleration)
	_player.update_velocity()
	
	if _blend > 0.0:
		_blend -= delta * 5
		_player.camera.set_arms_parameter("RunBlend/blend_amount", max(_blend, 0.0))
	
	#_weapon.idle(delta)
	#_weapon.mouse(delta)
	#_weapon.update(delta)
	
	#_weapon.sway_idle(delta)
	#_weapon.sway_weapon(delta)
	
	var on_floor = _player.is_on_floor()
	
	match Globals.option.crouch:
		Options.KeyMode.TOGGLE:
			if Input.is_action_just_pressed("crouch") and on_floor:
				delegated.emit("CrouchState")
		Options.KeyMode.HOLD:
			if Input.is_action_pressed("crouch") and on_floor:
				delegated.emit("CrouchState")
	
	if _player.velocity.length_squared() > 0.0 and on_floor:
		delegated.emit("SprintState")
		
	if Input.is_action_just_pressed("jump") and on_floor:
		delegated.emit("JumpState")

	#if Input.is_action_just_pressed("main_attack"):
		#_weapon.attack()

	if _player.velocity.y < 0.0 and not on_floor:
		delegated.emit("FallState")


func physics_update(delta: float):
	pass


#func on_attack_finished() -> void:
	#_weapon.load_pose(_weapon.idle_pose).duration(0.2)
