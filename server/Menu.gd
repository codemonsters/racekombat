extends CanvasLayer


signal change_to_saladeespera


func _input(event):
	pass
#	if event is InputEventKey and (event.scancode == KEY_ENTER or 
#		event.scancode == KEY_KP_ENTER):
#		emit_signal("change_to_saladeespera")
#		get_tree().set_input_as_handled()


func _on_StartButton_pressed():
	emit_signal("change_to_saladeespera")
