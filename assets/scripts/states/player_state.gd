class_name PlayerState
extends State

var _player: Player
var _animation: AnimationPlayer
var _shapecast: ShapeCast3D
var _weapon: WeaponController

func _ready() -> void:
	await owner.ready
	_player = owner as Player
	_animation = _player.animation_player
	_shapecast = _player.shapecast
	_weapon = _player.weapon


func on_attack_finished() -> void:
	pass
