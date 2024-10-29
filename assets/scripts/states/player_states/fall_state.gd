extends PlayerState

@export var speed: float = 4.0
@export var acceleration: float = 0.1
@export var deceleration: float = 0.25
@export var jump_velocity: float = 5.0
@export var coyotte_time: float = 0.5
@export var air_multiplier: float = 0.85
@export var jumps: int = 1

var _actual_speed: float
var _jump_count: int = 0
var _clock: float = 0.0
var _control: bool = true
var _air_time: float = 0.0

func enter(previous_state: String, state: State):
	_control = false
	if previous_state == "SlideState":
		_weapon.load_pose(_weapon.walk_pose).duration(0.3)
		
		await _animation.animation_finished
		
		_actual_speed = max(_player.velocity.length() / air_multiplier, 3.0)
		
		await get_tree().create_timer(0.1).timeout
		_control = true
	else:
		_control = true
		_actual_speed = max(_player.velocity.length(), 3.0)
	
	_animation.pause()
	
	_clock = 0.0
	_air_time = 0.0
	
	if previous_state == "JumpState":
		_jump_count = state._jump_count


func exit(next_state: String):
	pass


func update(delta: float):
	_player.update_gravity(delta)
	if _control:
		_player.update_input(_actual_speed * air_multiplier, acceleration, deceleration)
	_player.update_velocity()
	_actual_speed = lerp(_actual_speed, speed, delta)
	
	_weapon.mouse(delta)
	_weapon.update(delta)
	
	if _player.velocity.y < 0.0:
		_air_time += delta
	
	# Coyotte time, allow for jumping for a little time after falling
	if _jump_count == 0:
		_clock += delta
		if _clock >= coyotte_time:
			_jump_count = 1 # too late
	
	if Input.is_action_just_pressed("jump") and (_jump_count < jumps):
		_jump_count += 1
		delegated.emit("JumpState")
	
	if Input.is_action_just_released("jump"):
		if _player.velocity.y > 0.0:
			_player.velocity.y /= 1.5
	
	if _player.is_on_floor():
		_jump_count = 0
		delegated.emit("IdleState")


func physics_update(delta: float):
	pass
