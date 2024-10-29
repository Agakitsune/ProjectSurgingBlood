class_name PlayerModifier
extends Resource

@export var state_modifier: StateModifier

func visit(player: Player):
	state_modifier.visit(player.state_machine)


func reset(player: Player):
	state_modifier.reset(player.state_machine)
