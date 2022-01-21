extends StaticBody2D

var open = false


func open():
	if open:
		return

	$Tween.interpolate_property(self, "position:y", null, 510, 1.5, Tween.TRANS_QUINT)
	$Tween.start()

func close():
	if not open:
		return

	$Tween.interpolate_property(self, "position:y", null, 578, 1.5, Tween.TRANS_QUINT)
	$Tween.start()


func _on_Tween_tween_completed(object, key):
	open = not open
