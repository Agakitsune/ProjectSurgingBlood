class_name PlayerStateMachine
extends StateMachine

@export var PLAYER: Player
@export var ANIMATION: AnimationPlayer

var _debug_state := Label.new()

func _ready() -> void:
	for child in get_children():
		if child is PlayerState:
			_states[child.name] = child
			(child as State).delegated.connect(on_delegate)
			(child as State)._player = PLAYER
			(child as State)._animation = ANIMATION
	
	await owner.ready
	
	PLAYER.weapon.attack_finished.connect(on_attack_finished)
	
	_current = _default
	_current.enter("", null)
	
	Globals.player_state.text = "State: %s" % _current.name


func on_delegate(next_state: String) -> void:
	super.on_delegate(next_state)
			
	Globals.player_state.text = "State: %s" % _current.name
