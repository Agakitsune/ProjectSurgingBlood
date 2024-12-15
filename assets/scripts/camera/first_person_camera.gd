class_name FirstPersonCamera
extends Node3D
## A classic First Person Camera

@export var camera: Camera3D

@export var pitch_lower_limit := deg_to_rad(-90.0)
@export var pitch_upper_limit := deg_to_rad(90.0)
@export var arm_pitch_lower_limit := deg_to_rad(-70.0)
@export var arm_pitch_upper_limit := deg_to_rad(70.0)

@export var sensitivity := 0.5

@export var free_mode := false

@export_group("Free Mode")
@export var speed: float = 5.0

var last_rotation: float

var _mouse_input := false
var _mouse_rotation: Vector3
var _rotation_input: float
var _tilt_input: float

var _parent: Node3D

@onready var animation_tree: AnimationTree = $AnimationTree
@onready var arms_rig: Node3D = $Arms_Rig


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	_parent = get_parent() as Node3D


func _input(event: InputEvent) -> void:
	if free_mode:
		var input_dir := Input.get_vector("left", "right", "forward", "backward")
		var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		
		if direction:
			position.x += direction.x * speed
			position.z += direction.z * speed


func _unhandled_input(event: InputEvent) -> void:
	_mouse_input = (
			event is InputEventMouseMotion
			and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED
	)
	
	if _mouse_input:
		var mouse_event := event as InputEventMouseMotion
		_rotation_input = -mouse_event.relative.x * sensitivity
		_tilt_input = -mouse_event.relative.y * sensitivity


func _process(delta: float) -> void:
	last_rotation = _rotation_input
	_update_rotation(delta)
	_update_camera_with_parent(delta)
	
	_rotation_input = 0.0
	_tilt_input = 0.0


func set_arms_condition(condition: String, value: bool):
	animation_tree.set("parameters/conditions/" + condition, value)


func get_arms_condition(condition: String) -> bool:
	return animation_tree.get_condition("parameters/conditions/" + condition)


func _update_rotation(delta: float) -> void:
	_mouse_rotation.x += _tilt_input * delta
	_mouse_rotation.x = clamp(_mouse_rotation.x, pitch_lower_limit, pitch_upper_limit)
	_mouse_rotation.y += _rotation_input * delta


func _update_camera_with_parent(delta: float) -> void:
	var parent_rotation := Vector3(0.0, _mouse_rotation.y, 0.0)
	var camera_rotation := Vector3(_mouse_rotation.x, 0.0, 0.0)
	var arms_rotation := Vector3(clamp(
			_mouse_rotation.x,
			arm_pitch_lower_limit,
			arm_pitch_upper_limit
	), 0.0, 0.0)
	
	camera.basis = Basis.from_euler(camera_rotation)
	_parent.basis = Basis.from_euler(parent_rotation)
	arms_rig.basis = Basis.from_euler(arms_rotation)
