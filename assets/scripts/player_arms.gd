class_name PlayerArms
extends Node3D

@onready var animation_tree: AnimationTree = $AnimationTree


func set_parameter(anim: String, value: Variant):
	animation_tree.set("parameters/" + anim, value)


func get_parameter(anim: String) -> Variant:
	return animation_tree.get("parameters/" + anim)
