class_name Enemy
extends CharacterBody3D

const SPEED = 2.5
const JUMP_VELOCITY = 4.5

@export var data: EnemyData

@export var collider: CollisionShape3D
@export var frames: AnimatedSprite3D
@export var machine: EnemyStateMachine

var _life := 4.0

@onready var _spot := $Sprite3D

func _ready() -> void:
	if data:
		load_enemy(data)


func load_enemy(data: EnemyData) -> void:
	frames.offset.y = data.offset
	frames.sprite_frames = data.sprite_frames
	frames.scale = Vector3(data.scale, data.scale, data.scale)

	collider.shape.size = data.dimension
	collider.position.y = data.dimension.y / 2.0
	
	_life = data.health
	
	#_spot.position.y = data.height

	for script in data.states:
		var state := EnemyState.new()
		state.set_script(script)
		
		state.name = script.get_global_name()
		machine.add_child(state)
	
	machine.update()
	machine.default(data.default)


func damage(amount: float) -> void:
	_life -= amount
	if _life < 0:
		_life = 0

	if _life <= 0.0:
		queue_free()


func spotted(x: bool):
	if _spot:
		_spot.visible = x


func update_gravity(delta: float) -> void:
	velocity += get_gravity() * delta


func update_velocity() -> void:
	move_and_slide()
