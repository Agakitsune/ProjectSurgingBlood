#@tool
class_name WeaponController
extends Node3D

signal attack_finished

@export var data: WeaponData

@export_group("Weapon Poses")
@export var idle_pose: Pose
@export var walk_pose: Pose
@export var crouch_pose: Pose

@export var transition_duration: float = 1.0

@export_group("Render")
@export var mesh: MeshInstance3D
@export var shadow: MeshInstance3D
@export var deform: Script

@export_group("Randomize")
@export var noise: NoiseTexture2D

var mouse_movement: Vector2

var _time: float = 0.0

var _deform: WeaponDeform = WeaponDeform.new()
var _modifier: WeaponMod = WeaponMod.new()

var _old_pose: Pose
var _new_pose: Pose

var _attacks: Array[Attack]

@onready var _shoulder := $Shoulder
@onready var _elbow := $Shoulder/Elbow
@onready var _wrist := $Shoulder/Elbow/Wrist

@onready var _blunt := $Blunt

@onready var _animation := $AnimationPlayer

func _ready() -> void:
	load_data()
	load_deform()

	idle_pose.apply(_shoulder)
	_deform.pose = idle_pose
	_new_pose = idle_pose



func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		mouse_movement = event.relative


#func _process(delta: float) -> void:
	#if weapon:
		#sway_weapon(delta)

func load_data() -> void:
	if data:
		mesh.mesh = data.mesh
		shadow.mesh = data.mesh
		deform = data.deform_script

		idle_pose = data.idle
		walk_pose = data.walk
		crouch_pose = data.crouch

		shadow.visible = data.shadow
		
		_attacks = data.attacks
		
		_modifier.set_script(data.modifier_script)
		_modifier.modify(self)
		
		var library := AnimationLibrary.new()
		for atk in _attacks:
			var animation: Animation = atk.animation
			for i in range(animation.get_track_count()):
				var path: NodePath = animation.track_get_path(i)
				var names: String = (
						path.get_concatenated_names().replace("Anchor/", "")
				)
				var subnames: String = (
						path.get_concatenated_subnames()
				)
				animation.track_set_path(i, NodePath(names + ":" + subnames))
			library.add_animation(atk.name, animation)
		_animation.add_animation_library("custom", library)


func load_deform() -> void:
	_deform.set_script(deform)
	
	_deform.controller = self
	_deform.shoulder = _shoulder
	_deform.elbow = _elbow
	_deform.wrist = _wrist


func _interpolate_pose(value: float) -> void:
	var pose: Pose = Interpolation.pose_lerp(_old_pose, _new_pose, value)
	pose.apply(_shoulder)
	_deform.pose = pose


func load_pose(pose: Pose) -> BluntMethod:
	if _blunt.is_running():
		_blunt.kill()
	
	_old_pose = _new_pose
	_new_pose = pose
	return _blunt.method(_interpolate_pose, 0.0, 1.0, transition_duration)


func idle(delta: float) -> void:
	if _blunt.is_running():
		return

	if _animation.is_playing():
		return

	_deform.idle(delta, _time, get_noise())


func mouse(delta: float) -> void:
	if _blunt.is_running():
		return

	if _animation.is_playing():
		return
	
	_deform.mouse(delta, mouse_movement, _time)


func bob(delta: float, speed_factor: float, amount_factor: float) -> void:
	if _blunt.is_running():
		return

	if _animation.is_playing():
		return
	
	_deform.bob(delta, _time, speed_factor, amount_factor)


func update(delta: float) -> void:
	_time += delta
	
	if _blunt.is_sleeping():
		_blunt.run()


func attack() -> void:
	var atk: Attack = _attacks.pick_random()
	
	load_pose(atk.pose).duration(0.0001)
	await _blunt.finished
	
	_modifier.enable()
	
	_animation.play("custom/%s" % atk.name, -1.0, 1.0)
	await _animation.animation_finished
	_modifier.disable()
	
	attack_finished.emit()


func is_attacking() -> bool:
	return (
			_animation.current_animation.contains("attack")
			and _animation.is_playing()
	)


func get_noise() -> float:
	var player_position := Vector3.ZERO
	
	if not Engine.is_editor_hint():
		player_position = Globals.player.global_position
	
	var noise2d: float = noise.noise.get_noise_2d(player_position.x, player_position.y)
	return noise2d
