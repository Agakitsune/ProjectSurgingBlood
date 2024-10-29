class_name BluntProperty
extends BluntExecutable

static var _CALLBACKS: Array[Callable] = [
		LinearEasing.in_value,
		LinearEasing.out_value,
		LinearEasing.in_out_value,
		LinearEasing.out_in_value,
		
		SineEasing.in_value,
		SineEasing.out_value,
		SineEasing.in_out_value,
		SineEasing.out_in_value,
		
		QuadEasing.in_value,
		QuadEasing.out_value,
		QuadEasing.in_out_value,
		QuadEasing.out_in_value,
		
		CubicEasing.in_value,
		CubicEasing.out_value,
		CubicEasing.in_out_value,
		CubicEasing.out_in_value,
		
		QuartEasing.in_value,
		QuartEasing.out_value,
		QuartEasing.in_out_value,
		QuartEasing.out_in_value,
		
		QuintEasing.in_value,
		QuintEasing.out_value,
		QuintEasing.in_out_value,
		QuintEasing.out_in_value,
		
		ExpoEasing.in_value,
		ExpoEasing.out_value,
		ExpoEasing.in_out_value,
		ExpoEasing.out_in_value,
		
		CircEasing.in_value,
		CircEasing.out_value,
		CircEasing.in_out_value,
		CircEasing.out_in_value,
		
		BackEasing.in_value,
		BackEasing.out_value,
		BackEasing.in_out_value,
		BackEasing.out_in_value,
		
		ElasticEasing.in_value,
		ElasticEasing.out_value,
		ElasticEasing.in_out_value,
		ElasticEasing.out_in_value,
		
		BounceEasing.in_value,
		BounceEasing.out_value,
		BounceEasing.in_out_value,
		BounceEasing.out_in_value,
]


var _object: Node
var _property: StringName
var _start: Variant
var _final: Variant

var _easing: Blunt.BluntEasing = Blunt.BluntEasing.SINE
var _type: Blunt.BluntEasingType = Blunt.BluntEasingType.IN_OUT

var _easing_callback: Callable
var _interpolate_callback: Callable

#var _blunt: Blunt

func _init(object: Node, property: StringName, final: Variant, duration: float) -> void:
	_object = object
	_property = property
	_final = final
	_duration = duration
	_delay = 0.0


func prepare() -> void:
	_easing_callback = _CALLBACKS[(_easing << 2) + _type]
	_interpolate_callback = Interpolation.interpolate(_final)


func wake() -> void:
	_start = _object.get(_property)


func execute(t: float) -> void:
	_object.set(_property, _interpolate_callback.call(_start, _final, _easing_callback.call(t, 0.0, 1.0, _duration)))


func easing(easing: Blunt.BluntEasing) -> BluntProperty:
	_easing = easing
	return self


func easing_type(type: Blunt.BluntEasingType) -> BluntProperty:
	_type = type
	return self


func duration(duration: float) -> BluntProperty:
	_duration = duration
	return self


func delay(delay: float) -> BluntProperty:
	_delay = delay
	return self
