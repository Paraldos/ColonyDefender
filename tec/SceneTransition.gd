extends CanvasLayer

onready var anim = $Anim
onready var cr = $CR

func change_scene(target):
	anim.play("fade")
	yield(anim, "animation_finished")
	# warning-ignore:return_value_discarded
	get_tree().change_scene(target)
	yield(get_tree().create_timer(0.1), "timeout")
	get_tree().paused = false
	anim.play_backwards("fade")
