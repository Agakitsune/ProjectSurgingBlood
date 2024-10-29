class_name JumpState
extends PlayerState

@export var speed: float = 4.0
@export var acceleration: float = 0.1
@export var deceleration: float = 0.25
@export var jump_velocity: float = 5.0
@export var air_multiplier: float = 0.85
@export var jumps: int = 1

var _actual_speed: float
var _jump_count: int = 0

func enter(previous_state: String, state: State):
	_actual_speed = max(_player.velocity.length(), speed)
	_animation.play("Jump")
	
	if previous_state == "FallState":
		_jump_count = state._jump_count
		_player.velocity.y = jump_velocity
	else:
		_jump_count = 1
		_player.velocity.y += jump_velocity
	
	if (
			(previous_state != "WalkState")
			or (previous_state != "SprintState")
			or (previous_state != "JumpState")
	):
		_weapon.load_pose(_weapon.walk_pose).duration(0.2)


func exit(next_state: String):
	pass


func update(delta: float):
	_player.update_gravity(delta)
	_player.update_input(_actual_speed * air_multiplier, acceleration, deceleration)
	_player.update_velocity()
	
	_weapon.mouse(delta)
	_weapon.update(delta)
	
	if Input.is_action_just_pressed("jump") and (_jump_count < jumps):
		_jump_count += 1
		_player.velocity.y = jump_velocity
	
	if Input.is_action_just_released("jump"):
		if _player.velocity.y > 0.0:
			_player.velocity.y /= 1.5
	
	if _player.velocity.y < 0.0:
		delegated.emit("FallState")
	
	if _player.is_on_floor():
		_jump_count = 0
		if _player.velocity.length_squared() == 0.0:
			delegated.emit("IdleState")
		else:
			delegated.emit("WalkState")


func physics_update(delta: float):
	pass
