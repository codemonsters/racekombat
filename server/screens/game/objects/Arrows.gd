extends Node2D

var i = 2 # Para iluminar las flechas (índice)


func _ready():
	pass


func _on_ChangeTimer_timeout():
	$Node.get_child(i).color[-1] = 0.1
	i = (i + 1) % 3
	$Node.get_child(i).color[-1] = 0.5

func _on_FlickerTimer_timeout():
	$"ChangeTimer".stop()
	$"FlickerTimer".stop()
	i = 0
	_change_all_colors(0.1, 0)
	_change_all_colors(0.5, 0.1)
	yield(get_tree().create_timer(0.9), "timeout")
	_change_all_colors(0.1, 0)
	yield(get_tree().create_timer(0.5), "timeout")
	_change_all_colors(0.5, 0)
	yield(get_tree().create_timer(1.0), "timeout")
	_change_all_colors(0.1, 0)
	i = 2
	$"ChangeTimer".start()
	$"FlickerTimer".start()

func _change_all_colors(color, delay):
	if delay == 0: # Para evitar crear timers de cero
		for j in $Node.get_children().size():
			$Node.get_child(j).color[-1] = color
	else:
		for k in $Node.get_children().size():
			$Node.get_child(k).color[-1] = color
			yield(get_tree().create_timer(delay), "timeout")

