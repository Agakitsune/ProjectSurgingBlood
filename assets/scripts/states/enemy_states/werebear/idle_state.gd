class_name IdleWerebearState
extends EnemyState

func enter(previous_state: String, state: State):
	_frames.play("idle")
	
	_entity.spotted(false)


func exit(next_state: String):
	pass


func update(delta: float):
	if _entity.global_position.distance_squared_to(Globals.player.global_position) <= 91.0: # 5
		delegated.emit("WalkWerebearState")


func physics_update(delta: float):
	pass
