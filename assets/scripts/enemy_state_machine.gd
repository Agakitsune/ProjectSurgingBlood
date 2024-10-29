class_name EnemyStateMachine
extends StateMachine

@export var enemy: Enemy
@export var frames: AnimatedSprite3D

var _debug_state := Label.new()

func update():
	for child in get_children():
		if child is EnemyState:
			_states[child.name] = child
			(child as EnemyState).delegated.connect(on_delegate)
			(child as EnemyState)._entity = enemy
			(child as EnemyState)._frames = frames


func default(name: StringName):
	_current = _states[name]
	_current.enter("", null)
