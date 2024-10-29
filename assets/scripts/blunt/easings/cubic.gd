class_name CubicEasing
extends Easing

static func in_value(t: float, b: float, c: float, d: float) -> float:
	t /= d
	return c * t * t * t + b


static func out_value(t: float, b: float, c: float, d: float) -> float:
	t = t / d - 1
	return c * (t * t * t + 1) + b


static func in_out_value(t: float, b: float, c: float, d: float) -> float:
	t /= d / 2
	if t < 1:
		return c / 2 * t * t * t + b

	t -= 2
	return c / 2 * (t * t * t + 2) + b
