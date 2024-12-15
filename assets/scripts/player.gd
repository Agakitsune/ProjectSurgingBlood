class_name Player
extends CharacterBody3D

@export var camera: FirstPersonCamera
@export var animation_player: AnimationPlayer
@export var shapecast: ShapeCast3D
@export var state_machine: StateMachine

var weapon: WeaponController

var _direction: Vector3

func _ready() -> void:
	shapecast.add_exception(self)

	var _scene = preload("res://assets/scenes/weapon.tscn")
	weapon = _scene.instantiate()
	weapon.data = preload("res://assets/scripts/resources/weapon_datas/blade.tres")

	#camera.camera.add_child(weapon)

	Globals.player = self


func update_gravity(delta: float) -> void:
	velocity += get_gravity() * delta


func update_input(speed: float, acceleration: float, deceleration: float) -> bool:
	var input_dir := Input.get_vector("left", "right", "forward", "backward")
	_direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if _direction:
		velocity.x = lerp(velocity.x, _direction.x * speed, acceleration)
		velocity.z = lerp(velocity.z, _direction.z * speed, acceleration)
		return true
	velocity.x = move_toward(velocity.x, 0, deceleration)
	velocity.z = move_toward(velocity.z, 0, deceleration)
	return false


func update_speed(speed: float, acceleration: float, deceleration: float) -> void:
	if _direction:
		velocity.x = lerp(velocity.x, _direction.x * speed, acceleration)
		velocity.z = lerp(velocity.z, _direction.z * speed, acceleration)
	else:
		velocity.x = move_toward(velocity.x, 0, deceleration)
		velocity.z = move_toward(velocity.z, 0, deceleration)


func update_velocity() -> void:
	move_and_slide()
