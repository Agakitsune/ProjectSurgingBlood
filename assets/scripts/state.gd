class_name State
extends Node

signal delegated(transfer_state: String)

func enter(previous_state: String, state: State):
	pass


func exit(next_state: String):
	pass


func update(delta: float):
	pass


func physics_update(delta: float):
	pass
