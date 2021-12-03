extends Node2D


var controller_manager: ControllersManager


# Called when the node enters the scene tree for the first time.
func _ready():
	controller_manager = ControllersManager.new()
	controller_manager.add_controller(KeyboardController.new(controller_manager,
		KEY_W, KEY_S, KEY_A, KEY_D, [KEY_SPACE, KEY_SHIFT])
	)
	controller_manager.add_controller(KeyboardController.new(controller_manager,
		KEY_UP, KEY_DOWN, KEY_LEFT, KEY_RIGHT, [KEY_ENTER, KEY_KP_ENTER])
	)
	
	# Conecta la señal con la función. La hay que asignar a una variable pq sino 
	# lanza un warning :S
	var _im_just_trash = $CurrentScene/Menu.connect("change_to_saladeespera", self,
									   "change_to_saladeespera")


func change_to_saladeespera():
	get_node("CurrentScene/Menu").queue_free()
	var current_scene_container = get_node("CurrentScene")
	print(current_scene_container)
	var sala_de_espera = preload("res://WaitingRoom.tscn")
	current_scene_container.add_child(sala_de_espera.instance())


func _input(event):
	# TODO: ¡Esto ya no existe!
	controller_manager.handle_input(event)
