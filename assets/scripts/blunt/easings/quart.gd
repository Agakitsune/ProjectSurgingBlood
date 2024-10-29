class_name QuartEasing
extends Easing

static func in_value(t: float, b: float, c: float, d: float) -> float:
	return c * pow(t / d, 4) + b;


static func out_value(t: float, b: float, c: float, d: float) -> float:
	return -c * (pow(t / d - 1, 4) - 1) + b;


static func in_out_value(t: float, b: float, c: float, d: float) -> float:
	t = t / d * 2;

	if t < 1:
		return c / 2 * pow(t, 4) + b;
	return -c / 2 * (pow(t - 2, 4) - 2) + b;
