extends Node2D


var controllerManager: ControllersManager


# Called when the node enters the scene tree for the first time.
func _ready():
	controllerManager = ControllersManager.new()
	controllerManager.add_controller(KeyboardController.new(
		KEY_W, KEY_S, KEY_A, KEY_D, [KEY_SPACE, KEY_SHIFT])
	)
	controllerManager.add_controller(KeyboardController.new(
		KEY_UP, KEY_DOWN, KEY_LEFT, KEY_RIGHT, [KEY_ENTER, KEY_KP_ENTER])
	)
	
	# Conecta la señal con la función. La hay que asignar a una variable pq sino 
	# lanza un warning :S
	var _im_just_trash = $Menu.connect("change_to_saladeespera", self,
									   "change_to_saladeespera")


func change_to_saladeespera():
	get_node("Menu").queue_free()
	var screen_node = get_parent()
	var sala_de_espera = preload("res://WaitingRoom.tscn")
	screen_node.add_child(sala_de_espera.instance())

func _input(event):
	controllerManager.handle_input(event)
