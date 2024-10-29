class_name CircEasing
extends Easing

static func in_value(t: float, b: float, c: float, d: float) -> float:
	t /= d
	return -c * (sqrt(1 - t * t) - 1) + b


static func out_value(t: float, b: float, c: float, d: float) -> float:
	t = t / d - 1
	return c * sqrt(1 - t * t) + b


static func in_out_value(t: float, b: float, c: float, d: float) -> float:
	t /= d / 2
	if t < 1:
		return -c / 2 * (sqrt(1 - t * t) - 1) + b

	t -= 2
	return c / 2 * (sqrt(1 - t * t) + 1) + b
