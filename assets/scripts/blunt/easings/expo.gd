class_name ExpoEasing
extends Easing

static func in_value(t: float, b: float, c: float, d: float) -> float:
	if t == 0:
		return b
	return c * pow(2, 10 * (t / d - 1)) + b - c * 0.001


static func out_value(t: float, b: float, c: float, d: float) -> float:
	if t == d:
		return b + c
	return c * 1.001 * (-pow(2, -10 * t / d) + 1) + b


static func in_out_value(t: float, b: float, c: float, d: float) -> float:
	if t == 0:
		return b;

	if t == d:
		return b + c

	t = t / d * 2

	if t < 1:
		return c / 2 * pow(2, 10 * (t - 1)) + b - c * 0.0005
	return c / 2 * 1.0005 * (-pow(2, -10 * (t - 1)) + 2) + b
