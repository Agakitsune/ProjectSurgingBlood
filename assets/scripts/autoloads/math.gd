extends Node


static func decay_time(half_life: float) -> float:
	return log(2) / half_life


static func decay(a: Variant, b: Variant, decay: float, delta: float):
	return (a - b) * exp(-decay * delta) + b
