class_name Interpolation
extends Object

## Precise version to avoid overshooting
static func lerp(a: float, b: float, t: float) -> float:
	return (1 - t) * a + t * b


static func v2_lerp(a: Vector2, b: Vector2, t: float) -> Vector2:
	return Vector2(
			Interpolation.lerp(a.x, b.x, t),
			Interpolation.lerp(a.y, b.y, t),
	)


static func v3_lerp(a: Vector3, b: Vector3, t: float) -> Vector3:
	return Vector3(
			Interpolation.lerp(a.x, b.x, t),
			Interpolation.lerp(a.y, b.y, t),
			Interpolation.lerp(a.z, b.z, t),
	)


static func v4_lerp(a: Vector4, b: Vector4, t: float) -> Vector4:
	return Vector4(
			Interpolation.lerp(a.x, b.x, t),
			Interpolation.lerp(a.y, b.y, t),
			Interpolation.lerp(a.z, b.z, t),
			Interpolation.lerp(a.w, b.w, t),
	)


static func pose_lerp(a: Pose, b: Pose, t: float) -> Pose:
	var r: Pose = Pose.new()
	r.shoulder_position = v3_lerp(a.shoulder_position, b.shoulder_position, t)
	r.shoulder_rotation = v3_lerp(a.shoulder_rotation, b.shoulder_rotation, t)
	r.elbow_position = v3_lerp(a.elbow_position, b.elbow_position, t)
	r.elbow_rotation = v3_lerp(a.elbow_rotation, b.elbow_rotation, t)
	r.wrist_position = v3_lerp(a.wrist_position, b.wrist_position, t)
	r.wrist_rotation = v3_lerp(a.wrist_rotation, b.wrist_rotation, t)
	return r


static func interpolate(a: Variant) -> Callable:
	match typeof(a):
		TYPE_FLOAT:
			return Interpolation.lerp
		TYPE_VECTOR2:
			return Interpolation.v2_lerp
		TYPE_VECTOR3:
			return Interpolation.v3_lerp
		TYPE_VECTOR4:
			return Interpolation.v4_lerp
	return Callable()
