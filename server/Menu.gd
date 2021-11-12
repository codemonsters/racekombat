extends CanvasLayer


signal change_to_saladeespera


func _input(event):
	if event is InputEventKey and (event.scancode == KEY_ENTER or 
		event.scancode == KEY_KP_ENTER):
		emit_signal("change_to_saladeespera")


func _on_StartButton_pressed():
	emit_signal("change_to_saladeespera")
