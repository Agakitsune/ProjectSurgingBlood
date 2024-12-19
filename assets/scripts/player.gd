class_name Player
extends CharacterBody3D

@export var camera: FirstPersonCamera
@export var animation_player: AnimationPlayer
@export var shapecast: ShapeCast3D
@export var state_machine: StateMachine

var hspeed: float
var vspeed: float
var input: Vector3
var steering: Vector3
var floor: Basis
var gravity_pull: float

@onready var animation_tree: AnimationTree = $AnimationTree

func _ready() -> void:
	shapecast.add_exception(self)

	#var _scene = preload("res://assets/scenes/weapon.tscn")
	#weapon = _scene.instantiate()
	#weapon.data = preload("res://assets/scripts/resources/weapon_datas/blade.tres")

	#camera.camera.add_child(weapon)

	Globals.player = self


func update_gravity(delta: float) -> void:
	gravity_pull += -12 * delta
	#velocity += get_gravity() * delta


func update_input() -> bool:
	var input_dir := Input.get_vector("left", "right", "forward", "backward")
	input = (floor * Vector3(input_dir.x, 0, input_dir.y)).rotated(floor.y, rotation.y).normalized()
	return !!input


func update_velocity(speed: float, decay: float, delta: float) -> void:
	velocity = Math.decay(velocity, input * speed, decay, delta)
	hspeed = velocity.length()
	velocity.y += gravity_pull
	vspeed = gravity_pull


func accelerate(speed: float) -> void:
	velocity.x += input.x * speed
	velocity.z += input.z * speed
	var limited = Vector3(velocity.x, 0.0, velocity.z)
	hspeed = limited.length()
#
#
func limit(speed: float) -> void:
	var limited = Vector3(velocity.x, 0.0, velocity.z).limit_length(speed)
	velocity.x = limited.x
	velocity.z = limited.z
	hspeed = limited.length()
#
#
#func boost(value: float) -> void:
	#var boost = Vector3(velocity.x, 0.0, velocity.z)
	#var planar_speed = boost.length()
	#boost = boost.normalized() * (planar_speed + value)
	#velocity.x = boost.x
	#velocity.z = boost.z
	#self.hspeed = velocity.length()
#
#
#func steer(amount: float, decay: float, delta: float) -> void:
	#var input_dir := Input.get_vector("left", "right", "forward", "backward")
	#var dir = (basis * Vector3(input_dir.x, 0, 0)).normalized()
	#steering.x = Math.decay(steering.x, dir.x * amount, decay, delta)
	#steering.z = Math.decay(steering.z, dir.z * amount, decay, delta)
