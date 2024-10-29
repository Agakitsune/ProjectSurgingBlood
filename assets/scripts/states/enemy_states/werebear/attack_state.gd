class_name AttackWerebearState
extends EnemyState

var _lock: bool = false
var _direction: Vector3

func enter(previous_state: String, state: State):
	_lock = true
	_frames.play("pre_attack")
	
	await _frames.animation_finished
	
	await get_tree().create_timer(0.2).timeout
	_lock = false
	
	_entity.velocity.x = _direction.x * 10.0
	_entity.velocity.z = _direction.z * 10.0
	
	_frames.play("attack")
	
	await get_tree().create_timer(0.5).timeout
	_lock = true
	
	await get_tree().create_timer(0.5).timeout
	
	delegated.emit("WalkWerebearState")


func exit(next_state: String):
	pass


func update(delta: float):
	_direction = (_entity.global_position
			.direction_to(Globals.player.global_position)
	)
	
	if _lock:
		_entity.velocity = Vector3.ZERO
	
	_entity.update_gravity(delta)
	_entity.update_velocity()


func physics_update(delta: float):
	pass
