@tool
extends Node3D

@export var pose: Pose
@export var apply: bool:
	set(value):
		load_pose(pose)

@export var pose_name: StringName
@export var export: bool:
	set(value):
		_export()

func load_pose(pose: Pose) -> void:
	var node: Node3D = $Shoulder
	
	node.position = pose.shoulder_position
	node.rotation_degrees = pose.shoulder_rotation
	node = node.get_child(0)
	
	node.position = pose.elbow_position
	node.rotation_degrees = pose.elbow_rotation
	node = node.get_child(0)
	
	node.position = pose.wrist_position
	node.rotation_degrees = pose.wrist_rotation


func _export() -> void:
	var p: Pose = Pose.new()
	p.name = pose_name
	
	var node: Node3D = $Shoulder
	
	p.shoulder_position = node.position
	p.shoulder_rotation = node.rotation_degrees
	node = node.get_child(0)
	
	p.elbow_position = node.position
	p.elbow_rotation = node.rotation_degrees
	node = node.get_child(0)
	
	p.wrist_position = node.position
	p.wrist_rotation = node.rotation_degrees
	
	ResourceSaver.save(p,"res://assets/scripts/resources/poses/blade/%s.tres" % pose_name.to_lower())
	
