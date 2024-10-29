class_name Blunt
extends Node

enum BluntEasing {
	LINEAR = 0,
	SINE,
	QUAD,
	CUBIC,
	QUART,
	QUINT,
	EXPO,
	CIRC,
	BACK,
	ELASTIC,
	BOUNCE,
}

enum BluntEasingType {
	IN = 0,
	OUT,
	IN_OUT,
	OUT_IN,
}

signal finished()

var _sleeping_properties: Array[BluntExecutable]
var _active_properties: Array[BluntExecutable]

var _clock: float = 0.0
var _running := false


func _ready() -> void:
	pass


func _physics_process(delta: float) -> void:
	if _running:
		var i: int = 0
		
		_clock += delta
		while i < _sleeping_properties.size():
			var prop: BluntExecutable = _sleeping_properties[i]
			if _clock >= prop._delay:
				prop.wake()
				_active_properties.append(prop)
				_sleeping_properties[i] = _sleeping_properties[-1]
				_sleeping_properties.pop_back()
			else:
				i += 1

		i = 0
		while i < _active_properties.size():
			var prop: BluntExecutable = _active_properties[i]
			prop.execute(clamp(_clock - prop._delay, 0.0, prop._duration))
			if _clock >= (prop._delay + prop._duration):
				_active_properties[i] = _active_properties[-1]
				_active_properties.pop_back()
			else:
				i += 1
				
		if _sleeping_properties.is_empty() and _active_properties.is_empty():
			_running = false
			finished.emit()


func run() -> void:
	var i: int = 0
	
	_clock = 0.0
	while i < _sleeping_properties.size():
		var prop: BluntExecutable = _sleeping_properties[i]
		prop.prepare()
		if _clock >= prop._delay:
			prop.wake()
			_active_properties.append(prop)
			_sleeping_properties[i] = _sleeping_properties[-1]
			_sleeping_properties.pop_back()
		else:
			i += 1

	i = 0
	while i < _active_properties.size():
		var prop: BluntExecutable = _active_properties[i]
		prop.execute(_clock)
		if _clock >= (prop._delay + prop._duration):
			_active_properties[i] = _active_properties[-1]
			_active_properties.pop_back()
		else:
			i += 1

	_running = true
	
	if _sleeping_properties.is_empty() and _active_properties.is_empty():
		_running = false
		finished.emit()


func is_running() -> bool:
	return _running


func is_sleeping() -> bool:
	return not _running and not _sleeping_properties.is_empty()


func seek(time: float) -> void:
	var i: int = 0
	
	_clock = time
	while i < _sleeping_properties.size():
		var prop: BluntExecutable = _sleeping_properties[i]
		if _clock >= prop._delay:
			prop.wake()
			_active_properties.append(prop)
			_sleeping_properties[i] = _sleeping_properties[-1]
			_sleeping_properties.pop_back()
		else:
			i += 1

	i = 0
	while i < _active_properties.size():
		var prop: BluntExecutable = _active_properties[i]
		prop.execute(clamp(_clock - prop._delay, 0.0, prop._duration))
		if _clock >= (prop._delay + prop._duration):
			_active_properties[i] = _active_properties[-1]
			_active_properties.pop_back()
		else:
			i += 1
			
	if _sleeping_properties.is_empty() and _active_properties.is_empty():
		_running = false
		finished.emit()


func kill() -> void:
	seek(1.79769e308)


func property(object: Node, property: StringName, final: Variant, duration: float) -> BluntProperty:
	var prop := BluntProperty.new(object, property, final, duration)
	_sleeping_properties.append(prop)
	return prop


func callback(callback: Callable) -> BluntCallback:
	var call := BluntCallback.new(callback)
	_sleeping_properties.append(call)
	return call


func method(method: Callable, from: Variant, to: Variant, duration: float) -> BluntMethod:
	var meth := BluntMethod.new(method, from, to, duration)
	_sleeping_properties.append(meth)
	return meth


func group() -> BluntGroup:
	return BluntGroup.new(self)
