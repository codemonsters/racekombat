extends Node2D

var i = 2 # Para iluminar las flechas (índice)


func _ready():
	pass


func _on_Timer_timeout():
	$Node.get_child(i).color[-1] = 0.1
	i = (i + 1) % 3
	$Node.get_child(i).color[-1] = 0.5
	
