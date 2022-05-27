extends CanvasLayer


var active_button = Vector2(0, 0)


# Called when the node enters the scene tree for the first time.
func _ready():
	$Control/VBoxContainer/MarginContainer/HBoxContainer/VBoxContainer.get_children()[0].grab_focus()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match active_button.x:
		0.0:
			if active_button.y > $Control/VBoxContainer/MarginContainer/HBoxContainer/VBoxContainer.get_child_count():
				print("SI")


func controller_input(_controller, action, is_main, _is_pressed):
	print_debug("HJSRTJDHC")
	if not _is_pressed:
		return
	if is_main:
		match action:
			"up":
				active_button.x -= 1
			"down":
				active_button.x += 1
			"action":
				$Control.get_children()[active_button].set_pressed(true)
				$Control.get_children()[active_button].emit_signal("pressed")
