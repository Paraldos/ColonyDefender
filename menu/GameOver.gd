extends CanvasLayer

onready var restartTimer = $RestartTimer
onready var score = $MC/VC/Score

#################################################
func _ready():
	score.text = "Your Score: %s" % [Helper.score]

#################################################
func _on_BtnRestart_pressed():
	if !restartTimer.is_stopped(): return
	Helper._new_game()
	SceneTransition.change_scene("res://world/World.tscn")

func _on_BtnQuit_pressed():
	if !restartTimer.is_stopped(): return
	SceneTransition.change_scene("res://menu/StartScreen.tscn")
