extends CanvasLayer

signal change_to_saladeespera

var active_button = 0

func _ready():
	var lbl := $Label
	_move_text(lbl)

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


func controller_input(_controller, action, is_main):
	if is_main:
		match action:
			"up":
				active_button -= 1
			"down":
				active_button += 1
			"action":
				$Control.get_children()[active_button].set_pressed(true)
				$Control.get_children()[active_button].emit_signal("pressed")

func _move_text(label):
	var t = Timer.new()
	t.set_wait_time(0.03)
	t.set_one_shot(true)
	self.add_child(t)
	var accel = Vector2(50, 0)
	for _a in range(1, 41.88184959941402): # x = x0 + v0 * t + 1/2 * a * t^2
		label.rect_global_position += accel
		accel -= Vector2(1.2, 0)
		t.start()
		yield(t, "timeout")
