class_name DebugInterface
extends ModControl

var _data = {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.debug = self
	Globals.init_debug()
	
	visible = false


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("debug"):
		visible = not visible


func _add_from_list(str: String, path: PackedStringArray, control: Control) -> void:
	var lower: ModControl = get_node("%" + "%s" % str)
	if path.is_empty():
		lower._add(control)
	else:
		lower._add_from_list(path[0], path.slice(1), control)


func _register_node(name: String, control: Control) -> void:
	if name in _data:
		push_error("%s is already registerde in Debug Interface" % name)
	_data[name] = control
