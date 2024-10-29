class_name DoubleJumpModifier
extends StateModifier

@export var jumps: int = 2

var _saves = {
	
}

func visit(machine: StateMachine):
	var states: Array[Node] = machine.find_children("*", "JumpState")
	
	for state in states:
		var jump := state as JumpState
		_saves[jump.get_instance_id()] = jump.jumps
		jump.jumps = self.jumps


func reset(_machine: StateMachine):
	for id in _saves.keys():
		var jump := instance_from_id(id) as JumpState
		if jump:
			jump.jumps = _saves[id]
