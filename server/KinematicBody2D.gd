extends KinematicBody2D


var a = Vector2(0,1)

func _process(delta):
	move_and_collide(a)
	if Input.is_action_pressed("ui_right"):
		move_local_x(1)
	if Input.is_action_pressed("ui_left"):
		move_local_x(-1)
	if Input.is_action_pressed("ui_up"):
		pass
		#move_local_y()
	#if Input.is_action_pressed("ui_down"):
		#move_local_y(-1)
