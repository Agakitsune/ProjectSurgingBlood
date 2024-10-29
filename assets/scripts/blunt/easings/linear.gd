class_name LinearEasing
extends Easing

static func in_value(time: float, initial: float, delta: float, duration: float) -> float:
	return delta * time / duration + initial;


static func out_value(time: float, initial: float, delta: float, duration: float) -> float:
	return in_value(time, initial, delta, duration)


static func in_out_value(time: float, initial: float, delta: float, duration: float) -> float:
	return in_value(time, initial, delta, duration)


static func out_in_value(time: float, initial: float, delta: float, duration: float) -> float:
	return in_value(time, initial, delta, duration)
