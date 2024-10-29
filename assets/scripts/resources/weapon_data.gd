class_name WeaponData
extends Resource

enum WeaponType {
	MELEE,
	SHOOT
}

@export var name: StringName

@export var type: WeaponType

@export_group("Weapon Pose")
@export var idle: Pose
@export var walk: Pose
@export var crouch: Pose

@export var attacks: Array[Attack]

@export_group("Weapon Deform")
@export var deform_script: Script

@export_group("Weapon Modifier")
@export var modifier_script: Script

@export_category("Weapon Visual")
@export var mesh: Mesh
@export var shadow: bool
