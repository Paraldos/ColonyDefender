extends CanvasLayer

####################################
func _on_BtnStart_pressed():
	Helper._new_game()
	SceneTransition.change_scene("res://menu/StoryScreen.tscn")

func _on_BtnStart2_pressed():
	get_tree().quit()
