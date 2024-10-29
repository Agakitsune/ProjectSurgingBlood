class_name WalkWerebearState
extends EnemyState

func enter(previous_state: String, state: State):
	_frames.play("walk")
	
	_entity.spotted(true)


func exit(next_state: String):
	pass


func update(delta: float):
	var target_vector = (_entity.global_position
			.direction_to(Globals.player.global_position)
	)
	
	var distance := (_entity.global_position
			.distance_squared_to(Globals.player.global_position)
	)
	if distance >= 400.0: # 20
		delegated.emit("IdleWerebearState")
		
	if distance <= 25.0: # 5
		delegated.emit("AttackWerebearState")
	
	_entity.velocity.x = target_vector.x * 2.0
	_entity.velocity.z = target_vector.z * 2.0
	
	_entity.update_gravity(delta)
	_entity.update_velocity()
	
	#var target_basis= Basis.looking_at(target_vector)
	#_entity.basis = _entity.basis.slerp(target_basis, 0.5)


func physics_update(delta: float):
	pass
