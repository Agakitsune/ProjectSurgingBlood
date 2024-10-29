class_name QuadEasing
extends Easing

static func in_value(t: float, b: float, c: float, d: float) -> float:
	return c * pow(t / d, 2) + b


static func out_value(t: float, b: float, c: float, d: float) -> float:
	t /= d;
	return -c * t * (t - 2) + b


static func in_out_value(t: float, b: float, c: float, d: float) -> float:
	t = t / d * 2

	if t < 1:
		return c / 2 * pow(t, 2) + b
	return -c / 2 * ((t - 1) * (t - 3) - 1) + b
