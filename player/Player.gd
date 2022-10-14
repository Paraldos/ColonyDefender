extends KinematicBody2D
#################################################
var MISSILE = preload("res://Missile.tscn")
var EXPLOSION_BIG = preload("res://Explosion_Big.tscn")

#################################################
onready var timerAttack = $TimerAttack
onready var timerRespawn = $TimerRespawn
onready var audioAttack = $AudioAttack
onready var audioHit = $AudioHit
onready var sprite = $Sprite

var input_vector = Vector2.ZERO
var velocity = Vector2.ZERO
const ACCELERATION = 10
const MAX_SPEED = 100
const FRICTION = 0.2
const TIME_TO_RESPAWN = 1


#################################################
func _ready():
	pass # Replace with function body.

func _physics_process(_delta):
	if sprite.visible:
		_move()
		_attack()
		_self_destruct()
	else:
		velocity = Vector2.ZERO
	velocity = move_and_slide(velocity)

#################################################
### move
func _move():
	_get_input()
	_velocity()
	_friction()

func _get_input():
	input_vector.x = Input.get_action_strength("ui_left") - Input.get_action_strength("ui_right")

func _velocity():
	velocity.x -= input_vector.x * ACCELERATION
	velocity.x = clamp(velocity.x, -MAX_SPEED, MAX_SPEED)

func _friction():
	if input_vector.x == 0: velocity.x = lerp(velocity.x, 0, FRICTION)

### attack
func _attack():
	if Input.is_action_pressed("ui_accept") and timerAttack.is_stopped():
		timerAttack.start()
		var new = MISSILE.instance()
		new.global_position = Vector2(global_position.x, global_position.y - 6)
		new._assignment("player")
		get_parent().add_child(new)
		audioAttack.play()

### self destruct
func _self_destruct():
	if Input.is_action_just_pressed("ui_selfDestruct"): _hit()

#################################################
### hit
func _hit():
	if sprite.visible:
		Helper.lives -= 1
		sprite.visible = false
		timerRespawn.start(TIME_TO_RESPAWN)
		Helper.emit_signal("playerHit")
		_explosion()

func _explosion():
	audioHit.play()
	var new = EXPLOSION_BIG.instance()
	new.global_position = global_position
	get_parent().add_child(new)

#################################################
func _on_TimerRespawn_timeout():
	if Helper.lives > 0:
		sprite.visible = true
	else:
		SceneTransition.change_scene("res://menu/GameOver.tscn")
