extends KinematicBody2D


var a = Vector2(0,1)

func _process(delta):
	move_and_collide(a)
