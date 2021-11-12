extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	# ControllersManager.new()
	# Conecta la señal con la función. La hay que asignar a una variable pq sino 
	# lanza un warning :S
	var _im_just_trash = $Menu.connect("change_to_saladeespera", self,
									   "change_to_saladeespera")


func change_to_saladeespera():
	get_node("Menu").queue_free()
	var screen_node = get_parent()
	var sala_de_espera = preload("res://SaladeEspera.tscn")
	screen_node.add_child(sala_de_espera.instance())
