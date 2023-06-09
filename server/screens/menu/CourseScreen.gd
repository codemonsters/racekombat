extends CanvasLayer


var active_button = Vector2(0, 0)
var columns = []
var courses = {
		"Randomly created": "res://screens/game/Tilemap2_0.tscn",
		"World 1": "res://screens/game/courses/world1.tscn",
		"World 2": "res://screens/game/courses/world2.tscn",
}


# Called when the node enters the scene tree for the first time.
func _ready():
	$Control/VBoxContainer/MarginContainer/HBoxContainer/VBoxContainer.get_children()[0].grab_focus()
	columns = $Control/VBoxContainer/MarginContainer/HBoxContainer.get_children()


func _process(_delta):
	if active_button.x > len(columns) - 1: # Overflow right
		active_button.x = len(columns) - 1
	elif active_button.x < 0: # Overflow left
		active_button.x = 0
	
	var container = columns[active_button.x]
	
	if active_button.y > len(container.get_children()) - 1: # Overflow down
		active_button.y = len(container.get_children()) - 1
	elif active_button.y < 0: # Overflow up
		active_button.y = 0
	container.get_children()[active_button.y].grab_focus()


func controller_input(_controller, action, is_main, _is_pressed):
	if not _is_pressed:
		return
	if is_main:
		match action:
			"up":
				active_button.y -= 1
			"down":
				active_button.y += 1
			"left":
				active_button.x -= 1
			"right":
				active_button.x += 1
			"action":
				$Control.get_children()[active_button].set_pressed(true)
				$Control.get_children()[active_button].emit_signal("pressed")


func _on_Button_pressed(button_label):
	get_parent().get_parent().CourseResource = courses[button_label]

	get_parent().get_parent().change_to_saladeespera()
