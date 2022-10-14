extends Node2D
#################################################
var PAUSE = preload("res://menu/Pause.tscn")
var ENEMY = preload("res://enemies/EnemyTemplate.tscn")

#################################################
var rng = RandomNumberGenerator.new()
var start_score = 0
var start_lives = 3
var score = start_score
var lives = start_lives
var high_score = 0

#################################################
# warning-ignore:unused_signal
signal spawnNewEnemy
# warning-ignore:unused_signal
signal playerHit
signal enemyKilled

#################################################
func _ready():
	rng.randomize()

#################################################
func _new_game():
	score = start_score
	lives = start_lives

func _pause():
	var new = PAUSE.instance()
	get_tree().current_scene.add_child(new)

func _enemy_killed(x):
	score += x
	emit_signal("enemyKilled")
