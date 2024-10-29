class_name Area3DModifier
extends Area3D

@export var modifier: PlayerModifier


func _on_body_entered(body: Node3D) -> void:
	if body is Player:
		modifier.visit(body as Player)


func _on_body_exited(body: Node3D) -> void:
	if body is Player:
		modifier.reset(body as Player)
