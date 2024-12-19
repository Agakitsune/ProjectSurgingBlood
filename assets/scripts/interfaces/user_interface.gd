extends Control


func _process(delta: float) -> void:
	%HSpeed.text = "%.2f" % Globals.player.hspeed
	%VSpeed.text = "%.2f" % Globals.player.vspeed
