extends MarginContainer

onready var lives = $Lives
onready var score = $Score

#################################################
func _ready():
	_lives()
	Helper.connect("playerHit", self, "_lives")
	_score()
	Helper.connect("enemyKilled", self, "_score")

func _lives():
	lives.rect_min_size.x = 7 * Helper.lives

func _score():
	score.text = String(Helper.score)
