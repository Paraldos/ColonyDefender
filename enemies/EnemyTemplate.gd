extends KinematicBody2D
#################################################
var EXPLOSION = preload("res://Explosion.tscn")
var MISSILE = preload("res://Missile.tscn")

#################################################
var startPosition # gets set by spawner
var velocity = Vector2.ZERO
var direction = 0
var ACCELERATION = 5
var MAX_SPEED = 50
var TIME_TO_RESPAWN = 2
var points = 100

#################################################
func _physics_process(_delta):
	_check_for_wall_collision()
	_move()
	velocity = move_and_slide(velocity)

#################################################
func _check_for_wall_collision():
	if $RayCast_Left.is_colliding(): direction = 1
	if $RayCast_Right.is_colliding(): direction = -1

func _move():
	velocity.x += direction * ACCELERATION
	velocity.x = clamp(velocity.x, -MAX_SPEED, MAX_SPEED)

func _hit():
	_explosion()
	global_position = Vector2(-500, -500)
	$Respawn.start(TIME_TO_RESPAWN)
	Helper._enemy_killed(points)

func _explosion():
	var i = EXPLOSION.instance()
	i.global_position = global_position
	get_parent().add_child(i)
	$Explosion.play()

func _randomise_direction():
	direction = Helper.rng.randi_range(-1, 1)
	$Direction.start(Helper.rng.randi_range(0.1, 1))

func _respawn():
	Helper.emit_signal("spawnNewEnemy", startPosition)
	queue_free()

func _attack():
	var i = MISSILE.instance()
	i.global_position = Vector2(global_position.x, global_position.y)
	i._assignment("enemy")
	get_parent().add_child(i)
	$Attack.start(Helper.rng.randi_range(0.8, 1.5))

#################################################
func _on_Respawn_timeout(): _respawn()
func _on_Direction_timeout(): _randomise_direction()
func _on_Attack_timeout(): _attack()
