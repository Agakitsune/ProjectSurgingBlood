class_name BluntMethod
extends BluntExecutable

var _method: Callable
var _from: Variant
var _to: Variant

var _easing: Blunt.BluntEasing = Blunt.BluntEasing.SINE
var _type: Blunt.BluntEasingType = Blunt.BluntEasingType.IN_OUT

var _easing_callback: Callable
var _interpolate_callback: Callable

func _init(method: Callable, from: Variant, to: Variant, duration: float) -> void:
	_method = method
	_from = from
	_to = to
	_duration = duration
	_delay = 0.0


func prepare() -> void:
	_easing_callback = BluntProperty._CALLBACKS[(_easing << 2) + _type]
	_interpolate_callback = Interpolation.interpolate(_from)


func execute(t: float) -> void:
	_method.call(_interpolate_callback.call(_from, _to, _easing_callback.call(t, 0.0, 1.0, _duration)))


func easing(easing: Blunt.BluntEasing) -> BluntMethod:
	_easing = easing
	return self


func easing_type(type: Blunt.BluntEasingType) -> BluntMethod:
	_type = type
	return self


func duration(duration: float) -> BluntMethod:
	_duration = duration
	return self


func delay(delay: float) -> BluntMethod:
	_delay = delay
	return self
