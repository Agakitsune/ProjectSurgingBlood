class_name SlideState
extends PlayerState

@export var speed: float = 14.0
@export var boost: float = 5.0

func enter(previous_state: String, state: State):
	#_player.camera.set_arms_condition("idle", true)
	_player.animation_tree.set("parameters/conditions/idle", false)
	_player.animation_tree.set("parameters/conditions/slide", true)
	
	_player.boost(boost)


func exit(next_state: String):
	_player.camera.set_arms_condition("idle", false)
	_player.steering = Vector3.ZERO


func update(delta: float):
	#_player.update_gravity(delta)
	##_player.update_input()
	#_player.steer(15, 4, delta)
	#_player.update_velocity(speed, 1, delta)
	#_player.move_and_slide()
	
	#_weapon.idle(delta)
	#_weapon.mouse(delta)
	#_weapon.update(delta)
	
	#_weapon.sway_idle(delta)
	#_weapon.sway_weapon(delta)
	
	var on_floor = _player.is_on_floor()
	
	if Input.is_action_just_released("crouch"):
		delegated.emit("RunState")
	
	#match Globals.option.crouch:
		#Options.KeyMode.TOGGLE:
			#if Input.is_action_just_pressed("crouch") and on_floor:
				#delegated.emit("CrouchState")
		#Options.KeyMode.HOLD:
			#if Input.is_action_pressed("crouch") and on_floor:
				#delegated.emit("CrouchState")
	
	#if _player.direction and on_floor:
		#delegated.emit("RunState")
		
	#if Input.is_action_just_pressed("jump") and on_floor:
		#delegated.emit("JumpState")

	#if Input.is_action_just_pressed("main_attack"):
		#_weapon.attack()

	#if _player.velocity.y < 0.0 and not on_floor:
		#delegated.emit("FallState")


func physics_update(delta: float):
	pass
