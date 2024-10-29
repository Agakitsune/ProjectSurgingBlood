extends Node

var debug: DebugInterface
var option: Options
var player: Player

# World
var version := Label.new()
var fps := Label.new()

# Option
var crouch_label := Label.new()
var sprint_label := Label.new()

# Player
var player_state := Label.new()

func init_debug():
	# World
	var control = PanelContainer.new()
	control.name = "World"
	debug.add_from_path("TopLeft", control)
	
	control = VBoxContainer.new()
	control.name = "VBox"
	debug.add_from_path("TopLeft.World", control)

	version.text = "Project Surging Blood 0.0.1-alpha"

	debug.add_from_path("TopLeft.World.VBox", version)
	debug.add_from_path("TopLeft.World.VBox", fps)

	# Options
	control = PanelContainer.new()
	control.name = "Options"
	debug.add_from_path("TopLeft", control)
	
	control = VBoxContainer.new()
	control.name = "VBox"
	debug.add_from_path("TopLeft.Options", control)
	
	debug.add_from_path("TopLeft.Options.VBox", crouch_label)
	debug.add_from_path("TopLeft.Options.VBox", sprint_label)
	
	# Player
	control = PanelContainer.new()
	control.name = "Player"
	debug.add_from_path("TopLeft", control)
	
	control = VBoxContainer.new()
	control.name = "VBox"
	debug.add_from_path("TopLeft.Player", control)
	
	debug.add_from_path("TopLeft.Player.VBox", player_state)
