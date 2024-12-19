class_name JumpState
extends PlayerState

@export var speed: float = 0.2
@export var acceleration: float = 0.1
@export var deceleration: float = 0.25
@export var jump_velocity: float = 7.5
@export var air_multiplier: float = 0.85
@export var jumps: int = 1

var _limit: float
var _jump_count: int = 0
var _fall_distance: float
var _initial_input: Vector3

func enter(previous_state: String, state: State):
	#if previous_state == "FallState":
		#_jump_count = state._jump_count
		#_player.velocity.y = jump_velocity
	#else:
	_jump_count = 1
	_player.velocity += _player.floor.y * jump_velocity
	
	_player.camera.set_arms_condition("jump", true)
	_player.camera.set_arms_condition("fall", false)
	_player.camera.set_arms_condition("high_fall", false)
	_player.floor = Basis()
	
	_player.update_input()
	_initial_input = _player.input
	
	_fall_distance = _player.position.y
	
	if _player.hspeed > 4.0:
		_limit = _player.hspeed
	else:
		_limit = 4.0
	
	#if (
			#(previous_state != "WalkState")
			#or (previous_state != "SprintState")
			#or (previous_state != "JumpState")
	#):
		#_weapon.load_pose(_weapon.walk_pose).duration(0.2)


func exit(next_state: String):
	_player.camera.set_arms_condition("jump", false)


func update(delta: float):
	_player.update_gravity(delta)
	_player.update_input()
	_player.accelerate(speed)
	_player.limit(_limit)
	
	_player.velocity.y += _player.gravity_pull
	_player.gravity_pull = 0
	_player.vspeed = _player.velocity.y
	
	_player.move_and_slide()
	
	#_weapon.mouse(delta)
	#_weapon.update(delta)
	
	if Input.is_action_just_pressed("jump") and (_jump_count < jumps):
		_jump_count += 1
		_player.velocity.y = jump_velocity
		_player.velocity.x = _player.input.x * _limit
		_player.velocity.z = _player.input.z * _limit
		_player.limit(_limit)

	#
	#if Input.is_action_just_released("jump"):
		#if _player.velocity.y > 0.0:
			#_player.velocity.y /= 1.5
	#
	##if _player.velocity.y < 0.0:
		##delegated.emit("FallState")
	#
	if _player.is_on_floor():
		_jump_count = 0
		var distance = _fall_distance - _player.global_position.y
		if distance >= 1.0:
			_player.camera.set_arms_condition("high_fall", true)
		else:
			_player.camera.set_arms_condition("fall", true)
		if _player.hspeed == 0.0:
			delegated.emit("IdleState")
		else:
			delegated.emit("RunState")


func physics_update(delta: float):
	pass
