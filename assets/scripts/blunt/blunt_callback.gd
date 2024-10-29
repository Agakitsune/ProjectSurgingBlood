class_name BluntCallback
extends BluntExecutable

var _callback: Callable

func _init(callback: Callable) -> void:
	_callback = callback


func execute(t: float) -> void:
	_callback.call()


func delay(delay: float) -> BluntCallback:
	_delay = delay
	return self
