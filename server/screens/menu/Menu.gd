extends CanvasLayer

signal change_to_saladeespera
signal change_to_courses

var active_button = 0

func _ready():
	MusicManager.MenuMusicPlay()
	$"Title Tween".interpolate_property($Title, "global_position:x",
		null, 640, 1.0,
		Tween.TRANS_LINEAR, Tween.EASE_IN, 0.03
	)
	$"Title Tween".start()


func _on_StartButton_pressed():
	get_parent().get_parent().change_to_courses()
#	emit_signal("change_to_courses") 
#	Esta señal solo funcionaba al principio, pero no al salir de un nivel y renacer
#	Esta manera es más sencilla
	SfxManager.PlayerStartSound()

func _on_CourseButton_pressed():
	pass
	# TODO: llevar al usuario a una pantalla de créditos
	# emit_signal("change_to_courses")
	

func _on_ExitButton_pressed():
	get_tree().quit()


func _process(_delta):
	if active_button > len($Control.get_children()) - 1:
		active_button = 0
	elif active_button < 0:
		active_button = len($Control.get_children()) - 1

	$Control.get_children()[active_button].grab_focus()
	
	$Control/StartButton.set_scale(Vector2(1, 1))
	$Control/CourseButton.set_scale(Vector2(1, 1))
	$Control/ExitButton.set_scale(Vector2(1, 1))
	
	$Control/StartButton.set_position(Vector2(470, 280))
	$Control/CourseButton.set_position(Vector2(470, 430))
	$Control/ExitButton.set_position(Vector2(550, 580))
	
	if active_button == 0:
		$Control/StartButton.set_scale(Vector2(1.2, 1.2))
		$Control/StartButton.set_position(Vector2(440, 280))
	elif active_button == 1:
		$Control/CourseButton.set_scale(Vector2(1.2, 1.2))
		$Control/CourseButton.set_position(Vector2(440, 430))
	else:
		$Control/ExitButton.set_scale(Vector2(1.2, 1.2))
		$Control/ExitButton.set_position(Vector2(530, 580))


func controller_input(_controller, action, is_main, _is_pressed):
	if not _is_pressed:
		return
	if is_main:
		match action:
			"up":
				active_button -= 1
			"down":
				active_button += 1
			"action":
				$Control.get_children()[active_button].set_pressed(true)
				$Control.get_children()[active_button].emit_signal("pressed")

func player_disconnect(_controller):
	pass

#func _move_text(label):
#	var t = Timer.new()
#	t.set_wait_time(0.03)
#	t.set_one_shot(true)
#	self.add_child(t)
#	var accel = Vector2(50, 0)
#	for _a in range(1, 41.88184959941402): # x = x0 + v0 * t + 1/2 * a * t^2
#		label.global_position += accel
#		accel -= Vector2(1.2, 0)
#		t.start()
#		yield(t, "timeout")


# Focus is the same as hover animation :p
func _on_Button_mouse_entered(button_number):
	active_button = button_number
