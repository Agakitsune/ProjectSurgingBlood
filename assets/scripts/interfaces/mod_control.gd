class_name ModControl
extends Control

func add_from_path(path: String, control: Control) -> void:
	var array := path.split(".")
	_add_from_list(array[0], array.slice(1), control)


func get_from_path(path: String) -> Control:
	var array := path.split(".")
	return _get_from_list(array[0], array.slice(1))


func _add(control: Control) -> void:
	add_child(control)


func _add_from_list(str: String, path: PackedStringArray, control: Control) -> void:
	var node: Control = get_node("%" + "%s" % str)
	if not node:
		node = get_node(str)
		
	if path.is_empty():
		node.add_child(control)
		return
		
	for key in path:
		var tmp: Control = node.get_node("%" + "%s" % key)
		if not tmp:
			tmp = node.get_node(key)
			
		node = tmp
	
	node.add_child(control)


func _get_from_list(str: String, path: PackedStringArray) -> Control:
	var node: ModControl = get_node("%%s" % str)
	if not node:
		node = get_node(str)
		
	if not node:
		push_error("Unable to find node '%s'" % str)
		
	if path.is_empty():
		return node
	return node._get_from_list(path[0], path.slice(1))
