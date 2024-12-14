class_name Player
extends CharacterBody3D

@export var camera: FirstPersonCamera
@export var animation_player: AnimationPlayer
@export var shapecast: ShapeCast3D
@export var state_machine: StateMachine

var weapon: WeaponController
@onready var hook_cast = $FirstPersonCamera/Camera3D/HookCast3D
@onready var bonker = $FirstPersonCamera/HeadBonker

var hooking = false
var hookpoint = Vector3()
var hookpoint_get = false

var _direction: Vector3

func hook():
	if Input.is_action_just_pressed("spell"):
		print("Hook Pressed")
		if hook_cast.is_colliding():
			print("Hook Collide")
			if not hooking:
				print("Hook NOT Collide")
				hooking = true
	if hooking:
		velocity.y = 0
		if not hookpoint_get:
			hookpoint = hook_cast.get_collision_point() + Vector3(0, 2.25, 0)
			hookpoint_get = true
		if hookpoint.distance_to(transform.origin) > 1:
			if hookpoint_get:
				transform.origin = lerp(transform.origin, hookpoint, 0.05)
		else:
			hooking = false
			hookpoint_get = false
	if bonker.is_colliding():
		hooking = false
		hookpoint = null
		hookpoint_get = false
		global_translate(Vector3(0, -3, 0))

func _ready() -> void:
	shapecast.add_exception(self)

	var _scene = preload("res://assets/scenes/weapon.tscn")
	weapon = _scene.instantiate()
	weapon.data = preload("res://assets/scripts/resources/weapon_datas/blade.tres")

	camera.camera.add_child(weapon)

	Globals.player = self

func _process(delta: float):
	hook()

func update_gravity(delta: float) -> void:
	velocity += get_gravity() * delta

func update_input(speed: float, acceleration: float, deceleration: float) -> void:
	var input_dir := Input.get_vector("left", "right", "forward", "backward")
	_direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if _direction:
		velocity.x = lerp(velocity.x, _direction.x * speed, acceleration)
		velocity.z = lerp(velocity.z, _direction.z * speed, acceleration)
	else:
		velocity.x = move_toward(velocity.x, 0, deceleration)
		velocity.z = move_toward(velocity.z, 0, deceleration)

func update_speed(speed: float, acceleration: float, deceleration: float) -> void:
	if _direction:
		velocity.x = lerp(velocity.x, _direction.x * speed, acceleration)
		velocity.z = lerp(velocity.z, _direction.z * speed, acceleration)
	else:
		velocity.x = move_toward(velocity.x, 0, deceleration)
		velocity.z = move_toward(velocity.z, 0, deceleration)

func update_velocity() -> void:
	move_and_slide()
