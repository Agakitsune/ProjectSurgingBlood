class_name BluntGroup
extends Object

var _properties: Array[BluntExecutable]
var _blunt: Blunt

func _init(object: Blunt) -> void:
	_blunt = object


func property(object: Node, property: StringName, final: Variant, duration: float) -> BluntProperty:
	var prop := BluntProperty.new(object, property, final, duration)
	_properties.append(prop)
	return prop


func callback(callback: Callable) -> BluntCallback:
	var call := BluntCallback.new(callback)
	_properties.append(call)
	return call


func easing(easing: Blunt.BluntEasing) -> BluntGroup:
	for prop in _properties:
		prop.easing(easing)
	return self


func easing_type(type: Blunt.BluntEasingType) -> BluntGroup:
	for prop in _properties:
		prop.easing_type(type)
	return self


func duration(duration: float) -> BluntGroup:
	for prop in _properties:
		prop.duration(duration)
	return self


func delay(delay: float) -> BluntGroup:
	for prop in _properties:
		prop.delay(delay)
	return self


func end() -> Blunt:
	for prop in _properties:
		_blunt._sleeping_properties.append(prop)
	return _blunt
