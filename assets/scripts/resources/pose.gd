class_name Pose
extends Resource

@export var name: StringName

@export_category("Shoulder")
@export var shoulder_position: Vector3
@export var shoulder_rotation: Vector3

@export_category("Elbow")
@export var elbow_position: Vector3
@export var elbow_rotation: Vector3

@export_category("Wrist")
@export var wrist_position: Vector3
@export var wrist_rotation: Vector3

func apply(shoulder: Node3D) -> void:
	shoulder.position = shoulder_position
	shoulder.rotation_degrees = shoulder_rotation
	
	var elbow: Node3D = shoulder.get_child(0)
	elbow.position = elbow_position
	elbow.rotation_degrees = elbow_rotation
	
	var wrist: Node3D = elbow.get_child(0)
	wrist.position = wrist_position
	wrist.rotation_degrees = wrist_rotation


func _to_string() -> String:
	return "Pose <%s>" % name
