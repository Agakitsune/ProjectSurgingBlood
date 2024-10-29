class_name BackEasing
extends Easing

static func in_value(t: float, b: float, c: float, d: float) -> float:
	var s := 1.70158
	t /= d

	return c * t * t * ((s + 1) * t - s) + b


static func out_value(t: float, b: float, c: float, d: float) -> float:
	var s := 1.70158
	t = t / d - 1

	return c * (t * t * ((s + 1) * t + s) + 1) + b


static func in_out_value(t: float, b: float, c: float, d: float) -> float:
	var s := 1.70158 * 1.525
	t /= d / 2

	if t < 1:
		return c / 2 * (t * t * ((s + 1) * t - s)) + b

	t -= 2
	return c / 2 * (t * t * ((s + 1) * t + s) + 2) + b
