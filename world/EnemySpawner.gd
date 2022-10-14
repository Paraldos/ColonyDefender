extends Node2D

#################################################
onready var TOP = $Top.global_position
onready var MIDDLE = $Middle.global_position
onready var BOTTOM = $Bottom.global_position
var spawnNumber = 0

#################################################
func _ready():
	Helper.connect("spawnNewEnemy", self, "_spawn_enemy")

#################################################
func _spawn_enemy(pos):
	var enemy = Helper.ENEMY.instance()
	enemy.global_position = Vector2(pos.x + Helper.rng.randi_range(-40, 40), pos.y)
	enemy.startPosition = pos
	get_parent().add_child(enemy)

#################################################
func _on_LevelStart_timeout():
	match spawnNumber:
		0: _spawn_enemy(TOP)
		1: _spawn_enemy(MIDDLE)
		2: _spawn_enemy(BOTTOM)
	spawnNumber += 1
	if spawnNumber == 3: $Timer.stop()
