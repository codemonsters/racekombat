
extends Camera2D
const MOVE_SPEED = 100
func _process(delta):
	if Input.is_action_pressed(“ui_left”)):
		global_position += Vector2.LEFT * delta * MOVE_SPEED
	elif Input.is_action_pressed(“ui_right”)):
		global_position += Vector2.RIGHT * delta * MOVE_SPEED
