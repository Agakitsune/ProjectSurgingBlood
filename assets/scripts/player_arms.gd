class_name PlayerArms
extends Node3D

@export var default: StringName
@export var animation_player: AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation_player.play(default)


func play(anim: StringName, speed := 1.0, from_end := false, blend := -1.0):
	animation_player.play(anim, blend, speed, from_end)
