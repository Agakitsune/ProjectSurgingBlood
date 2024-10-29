class_name StateMachine
extends Node

@export var _default: State

var _current: State
var _states := {}

func _ready() -> void:
	for child in get_children():
		if child is State:
			_states[child.name] = child
			(child as State).delegated.connect(on_delegate)
	
	await owner.ready
	
	if _default:
		_current = _default
		_current.enter("", null)


func _process(delta: float) -> void:
	_current.update(delta)


func _physics_process(delta: float) -> void:
	_current.physics_update(delta)


func on_delegate(next_state: String) -> void:
	var next: State = _states.get(next_state)
	if next:
		if next != _current:
			_current.exit(next_state)
			next.enter(_current.name, _current)
			_current = next
			
			Globals.player_state.text = "State: %s" % _current.name


func on_attack_finished() -> void:
	_current.on_attack_finished()
