extends WeaponMod

var _body := Area3D.new()
var _collider := CollisionShape3D.new()

var _damage := 2.0

func _init() -> void:
	var shape := BoxShape3D.new()
	shape.size = Vector3(0.1, 0.8, 0.1)
	_collider.shape = shape
	
	_body.body_entered.connect(on_hit)
	_body.set_collision_mask_value(1, false)
	#_body.set_collision_layer_value(1, false)


func modify(root: Node3D) -> void:
	root = root.get_child(0)
	root = root.get_child(0)
	root = root.get_child(0)
	
	root.add_child(_body)
	_body.add_child(_collider)
	_body.position.y = 0.46


func enable():
	_body.set_collision_mask_value(1, true)


func disable():
	_body.set_collision_mask_value(1, false)


func on_hit(body: Node3D) -> void:
	if body.is_in_group("enemy"):
		body.damage(_damage)
