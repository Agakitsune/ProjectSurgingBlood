class_name ElasticEasing
extends Easing

static func in_value(t: float, b: float, c: float, d: float) -> float:
	if t == 0:
		return b

	t /= d
	if t == 1:
		return b + c

	t -= 1
	var p := d * 0.3
	var a := c * pow(2, 10 * t)
	var s := p / 4

	return -(a * sin((t * d - s) * (2 * PI) / p)) + b


static func out_value(t: float, b: float, c: float, d: float) -> float:
	if t == 0:
		return b

	t /= d
	if t == 1:
		return b + c

	var p := d * 0.3
	var s := p / 4

	return (c * pow(2, -10 * t) * sin((t * d - s) * (2 * PI) / p) + c + b)


static func in_out_value(t: float, b: float, c: float, d: float) -> float:
	if t == 0:
		return b

	t /= d / 2
	if t == 2:
		return b + c

	var p := d * (0.3 * 1.5)
	var a := c
	var s := p / 4

	if t < 1:
		t -= 1
		a *= pow(2, 10 * t)
		return -0.5 * (a * sin((t * d - s) * (2 * PI) / p)) + b

	t -= 1
	a *= pow(2, -10 * t)
	return a * sin((t * d - s) * (2 * PI) / p) * 0.5 + c + b
