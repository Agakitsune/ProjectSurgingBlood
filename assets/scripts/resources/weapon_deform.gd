class_name WeaponDeform
extends Resource

var controller: Node3D
var shoulder: Node3D
var elbow: Node3D
var wrist: Node3D

var pose: Pose

func idle(delta: float, time: float, noise: float) -> void:
	pass


func mouse(delta: float, mouse_input: Vector2, time: float) -> void:
	pass


func bob(delta: float, time: float, speed_factor: float, amount_factor: float) -> void:
	pass
