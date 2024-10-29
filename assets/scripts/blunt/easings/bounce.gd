class_name BounceEasing
extends Easing

static func in_value(t: float, b: float, c: float, d: float) -> float:
	t /= d;

	if t < (1 / 2.75):
		return c * (7.5625 * t * t) + b;

	if t < (2 / 2.75):
		t -= 1.5 / 2.75;
		return c * (7.5625 * t * t + 0.75) + b;

	if t < (2.5 / 2.75):
		t -= 2.25 / 2.75;
		return c * (7.5625 * t * t + 0.937) + b;

	t -= 2.625 / 2.75;
	return c * (7.5625 * t * t + 0.984375) + b;


static func out_value(t: float, b: float, c: float, d: float) -> float:
	return c - out_value(d - t, 0, c, d) + b;


static func in_out_value(t: float, b: float, c: float, d: float) -> float:
	var h := c / 2.0
	if t < d / 2:
		return in_value(t * 2, b, h, d);
	return out_value(t * 2 - d, b + h, h, d);
