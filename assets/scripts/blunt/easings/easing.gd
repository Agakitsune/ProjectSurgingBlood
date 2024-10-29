class_name Easing
extends Object


static func in_value(time: float, initial: float, delta: float, duration: float) -> float:
	return 1.0


static func out_value(time: float, initial: float, delta: float, duration: float) -> float:
	return 1.0


static func in_out_value(time: float, initial: float, delta: float, duration: float) -> float:
	return 1.0


static func out_in_value(t: float, b: float, c: float, d: float) -> float:
	var h: float = c / 2.0
	if t < d / 2:
		return out_value(t * 2, b, c / 2, d);
	return in_value(t * 2 - d, b + h, h, d);
