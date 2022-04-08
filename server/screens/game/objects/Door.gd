extends StaticBody2D

var open = false
var moving = 0 # Moving up/down. -1: closing, 0: idle, 1: opening
var do_asap = 0 # Do as soon as possible. -1: close, 0: do nothing, 1: open


func open():
	if moving != 0:
		do_asap = 1
	else:
		$Tween.interpolate_property(self, "position:y", null, 490, 1.5, Tween.TRANS_QUINT)
		$Tween.start()
		moving = 1


func close():
	if moving != 0:
		do_asap = -1
	else:
		$Tween.interpolate_property(self, "position:y", null, 578, 1.5, Tween.TRANS_QUINT)
		$Tween.start()
		moving = -1


func _on_Tween_tween_completed(object, key):
	open = not open
	moving = 0
	if do_asap == 1:
		open()
	elif do_asap == -1:
		close()
