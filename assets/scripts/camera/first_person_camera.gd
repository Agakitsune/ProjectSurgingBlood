class_name FirstPersonCamera
extends Node3D
## A classic First Person Camera

@export var parent: Node3D ## Will rotate with the camera

@export var camera: Camera3D

@export var pitch_lower_limit := deg_to_rad(-90.0)
@export var pitch_upper_limit := deg_to_rad(90.0)

@export var sensitivity := 0.5

@export var free_mode := false

@export_group("Free Mode")
@export var speed: float = 5.0

var last_rotation: float

var _mouse_input := false
var _mouse_rotation: Vector3
var _rotation_input: float
var _tilt_input: float

var _c: int = 0
var _k: float = 0.0

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	if not parent:
		parent = get_parent() as Node3D


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
	if parent:
		_update_camera_with_parent(delta)
	else:
		_update_camera(delta)
	
	_rotation_input = 0.0
	_tilt_input = 0.0


func _update_rotation(delta: float) -> void:
	_mouse_rotation.x += _tilt_input * delta
	_mouse_rotation.x = clamp(_mouse_rotation.x, pitch_lower_limit, pitch_upper_limit)
	_mouse_rotation.y += _rotation_input * delta


func _update_camera_with_parent(delta: float) -> void:
	var parent_rotation := Vector3(0.0, _mouse_rotation.y, 0.0)
	var camera_rotation := Vector3(_mouse_rotation.x, 0.0, 0.0)
	
	camera.transform.basis = Basis.from_euler(camera_rotation)
	parent.transform.basis = Basis.from_euler(parent_rotation)


func _update_camera(delta: float) -> void:
	camera.transform.basis = Basis.from_euler(_mouse_rotation)
