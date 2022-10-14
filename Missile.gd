extends Node2D
#################################################
var SPEED = Vector2.ZERO


#################################################
func _physics_process(_delta):
	position += SPEED

#################################################
func _assignment(x):
	if x == "player":
		SPEED.y = -2
		$Area2D.collision_layer = 2
		$Area2D.collision_mask = 5
	if x == "enemy":
		SPEED.y = 2
		$Area2D.collision_layer = 4
		$Area2D.collision_mask = 3


#################################################
func _on_Area2D_body_entered(body):
	if body.has_method("_hit"):
		body._hit()
	queue_free()
