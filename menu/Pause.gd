extends CanvasLayer

onready var anim = $Anim

#################################################
func _ready():
	get_tree().paused = true

func _physics_process(_delta):
	if Input.is_action_just_pressed("ui_pause"):
		anim.play("end")
		get_tree().paused = false

#################################################
func _on_BtnContinue_pressed():
	anim.play("end")
	get_tree().paused = false

func _on_BtnQuit_pressed():
	SceneTransition.change_scene("res://menu/StartScreen.tscn")
