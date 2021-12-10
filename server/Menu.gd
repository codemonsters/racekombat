extends CanvasLayer

signal change_to_saladeespera

var active_button = 0


# TODO: ¿Por qué detecta "action" venga del controller que venga, y a continuación cambia de escena?
# ¿Podría tener que ver con el focus?
func _on_StartButton_pressed():
	emit_signal("change_to_saladeespera")


func _process(_delta):
	if active_button > len($Control.get_children()) - 1:
		active_button = 0
	elif active_button < 0:
		active_button = len($Control.get_children()) - 1

	$Control.get_children()[active_button].grab_focus()


func controller_input(controller, action, is_main):
	if is_main:
		match action:
			"up":
				active_button -= 1
			"down":
				active_button += 1
