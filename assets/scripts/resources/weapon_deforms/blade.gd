class_name Blade
extends WeaponDeform

const _MOUSE_SPEED := 0.07
const _MOUSE_AMOUNT := 0.2

const _RANDOM_STRENGTH := 0.5
const _RANDOM_ROTATION_STRENGTH := 30.0
const _RANDOM_AMOUNT := 1.0
const _RANDOM_SPEED := 0.1

const _BOB_SPEED := 0.9

func idle(delta: float, time: float, noise: float) -> void:
	var noise_adjusted := noise * _RANDOM_STRENGTH

	var decal := Vector3(
		sin(time * 1.5 + noise_adjusted) / _RANDOM_AMOUNT,
		sin(time - noise_adjusted) / _RANDOM_AMOUNT,
		sin(time * 0.5 + noise_adjusted) / _RANDOM_AMOUNT
	) * delta

	wrist.position.x = lerp(
			wrist.position.x,
			pose.wrist_position.x
			- decal.x,
			_RANDOM_SPEED
	)
	wrist.position.y = lerp(
			wrist.position.y,
			pose.wrist_position.y
			- decal.y,
			_RANDOM_SPEED
	)
	wrist.position.z = lerp(
			wrist.position.z,
			pose.wrist_position.z
			- decal.z,
			_RANDOM_SPEED
	)

	wrist.rotation_degrees.x = lerp(wrist.rotation_degrees.x,
			pose.wrist_rotation.x
			- decal.z * _RANDOM_ROTATION_STRENGTH,
			_RANDOM_SPEED
	)
	wrist.rotation_degrees.y = lerp(wrist.rotation_degrees.y,
			pose.wrist_rotation.y
			+ decal.y * _RANDOM_ROTATION_STRENGTH,
			_RANDOM_SPEED
	)
	wrist.rotation_degrees.z = lerp(wrist.rotation_degrees.z,
			pose.wrist_rotation.z
			- decal.z * _RANDOM_ROTATION_STRENGTH,
			_RANDOM_SPEED
	)


func mouse(delta: float, mouse_input: Vector2, time: float) -> void:
	controller.position.x = lerp(
			controller.position.x,
			mouse_input.x * _MOUSE_AMOUNT * delta,
			_MOUSE_SPEED
	)
	controller.position.y = lerp(
			controller.position.y,
			mouse_input.y * _MOUSE_AMOUNT * delta,
			_MOUSE_SPEED
	)


func bob(delta: float, time: float, speed_factor: float, amount_factor: float) -> void:
	controller.position.x = lerp(
			controller.position.x,
			cos(time * speed_factor) * amount_factor,
			_BOB_SPEED
	)
	controller.position.y = lerp(
			controller.position.y,
			abs(sin(time * speed_factor) * amount_factor),
			_BOB_SPEED
	)
