class_name EnemyData
extends Resource

@export var name: StringName

@export var health: float

@export_group("Enemy Dimension")
@export var offset: int
@export var height: float
@export var scale: float
@export var dimension: Vector3

@export_group("Ennemy Visual")
@export var sprite_frames: SpriteFrames

@export_group("Enemy States")
@export var states: Array[Script]
@export var default: StringName
