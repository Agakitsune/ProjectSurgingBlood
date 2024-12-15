class_name PlayerArms
extends Node3D

@onready var animation_tree: AnimationTree = $AnimationTree


func set_condition(condition: String, value: bool):
	animation_tree.set("parameters/conditions/" + condition, value)


func get_condition(condition: String) -> bool:
	return animation_tree.get("parameters/conditions/" + condition)
