class_name Options
extends Node

enum KeyMode {
	TOGGLE,
	HOLD,
}

@export var crouch := KeyMode.TOGGLE
@export var sprint := KeyMode.HOLD

var _crouch_label := Label.new()
var _sprint_label := Label.new()

func _ready():
	Globals.option = self

	Globals.crouch_label.text = "Crouch: %s" % ("Toggle" if crouch == 0 else "Hold")
	Globals.sprint_label.text = "Sprint: %s" % ("Toggle" if sprint == 0 else "Hold")
