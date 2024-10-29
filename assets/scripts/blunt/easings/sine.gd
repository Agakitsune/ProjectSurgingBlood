class_name SineEasing
extends Easing

static func in_value(time: float, initial: float, delta: float, duration: float) -> float:
	return -delta * cos((time / duration) * (PI / 2.0)) + delta + initial


static func out_value(time: float, initial: float, delta: float, duration: float) -> float:
	return delta * sin((time / duration) * (PI / 2.0)) + initial


static func in_out_value(time: float, initial: float, delta: float, duration: float) -> float:
	return -delta / 2.0 * (cos(PI * time / duration) - 1) + initial
