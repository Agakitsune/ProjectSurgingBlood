extends GutTest

var _enemy: Enemy

func before_each():
	_enemy = Enemy.new()
	
func before_all():
	gut.p("== Testing enemy ==", 1)
	
# Testing if the enemy is properly loaded
func test_assert_enemy_loaded():
	# Loading sample data
	var data = load("res://assets/scripts/resources/enemies/werebear.tres")
	_enemy.data = data
	_enemy.collider = CollisionShape3D.new()
	_enemy.collider.shape = BoxShape3D.new()
	
	_enemy.frames = AnimatedSprite3D.new()
	_enemy.machine = EnemyStateMachine.new()
	_enemy.machine.enemy = _enemy
	_enemy.machine.frames = _enemy.frames
	
	# Make sure "_ready" function is called by adding it as a child
	_enemy._ready()
	
	# Check if data is valid
	assert_not_null(data.name)
	assert_eq(data.states.size() > 0, true, "There is no states")
	
	assert_eq(int(_enemy._life), data.health, "Enemy life is not equal to input data")
	assert_eq(_enemy.frames.offset.y, data.offset, "Offset is invalid")
	assert_eq(_enemy.frames.sprite_frames, data.sprite_frames, "Sprite frames are invalid")
	assert_eq(_enemy.frames.scale, Vector3(data.scale, data.scale, data.scale), "Enemy scale is invalid")
	assert_eq(_enemy.collider.shape.size, data.dimension, "Dimension is invalid")
	assert_eq(_enemy.collider.position.y, data.dimension.y / 2.0, "Enemy position y invalid")

# We check if whatever damage we deal,
# the player's health stay above 0
func test_assert_hp_superior_to_zero():
	_enemy.damage(9999999)
	assert_eq(int(_enemy._life), 0, "Enemy life is not equal to 0")
