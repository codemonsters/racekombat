extends CanvasLayer


var active_button = Vector2(0, 0)
var columns = []


# Called when the node enters the scene tree for the first time.
func _ready():
	$Control/VBoxContainer/MarginContainer/HBoxContainer/VBoxContainer.get_children()[0].grab_focus()
	columns = $Control/VBoxContainer/MarginContainer/HBoxContainer.get_children()


func _process(_delta):
	if len(columns) < active_button.x + 1:
		active_button.x = 0
	elif len(columns) < active_button.y + 1:
		active_button.y = 0
		
	var container = columns[active_button.y]
	container.get_children()[active_button.x].grab_focus()
	print(active_button)


func controller_input(_controller, action, is_main, _is_pressed):
	if not _is_pressed:
		return
	if is_main:
		match action:
			"up":
				active_button.x -= 1
			"down":
				active_button.x += 1
			"left":
				active_button.y -= 1
			"right":
				active_button.y += 1
			"action":
				$Control.get_children()[active_button].set_pressed(true)
				$Control.get_children()[active_button].emit_signal("pressed")
