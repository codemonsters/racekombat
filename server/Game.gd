extends Node2D


var controller_manager: ControllersManager
const DISABLE_SEARCH = false # INFO: Set to false to connect controllers while debugging

onready var current_scene_container = get_node("CurrentScene")
onready var WaitingRoomResource = preload("res://screens/game/WaitingRoom.tscn")
onready var MenuResource = preload("res://screens/menu/Menu.tscn")
onready var CourseSelectionScreenResource = preload("res://screens/menu/CourseScreen.tscn")
onready var CourseResource = "res://screens/game/Tilemap2_0.tscn"


# Called when the node enters the scene tree for the first time.
func _ready():
	MusicManager.UnmuffleMusic()
	controller_manager = ControllersManager.new(self)
	controller_manager.add_controller(KeyboardController.new(controller_manager,
		KEY_W, KEY_S, KEY_A, KEY_D, KEY_V, KEY_B)
	)
	controller_manager.add_controller(KeyboardController.new(controller_manager,
		KEY_UP, KEY_DOWN, KEY_LEFT, KEY_RIGHT, KEY_N, KEY_M)
	)
	
#	DEBUG: Esto sirve para que cada tecla numérica cree un personaje (para debug de muchos jugadores)
#	for i in range(48, 57):
#		controller_manager.add_controller(KeyboardController.new(controller_manager,
#			i, 0, 0, 0, 0, 0)
#		)
	
	
	
	# Conecta la señal con la función. La hay que asignar a una variable pq sino 
	# lanza un warning :S
	var _im_just_trash = $CurrentScene/Menu.connect("change_to_saladeespera", self,
									   "change_to_saladeespera")
	
# Sí, esto ↓ también era una opción pero lo descubrimos más tarde. Dejémoslo así, queda bonito :)
# warning-ignore:return_value_discarded
	$CurrentScene/Menu.connect("change_to_courses", self,
									   "change_to_courses")
	

	# warning-ignore:return_value_discarded
	GamePad.connect("gamepad_connected", self, "_on_GamePad_controller_connected")
	# warning-ignore:return_value_discarded
	GamePad.connect("gamepad_disconnected", self, "_on_GamePad_controller_disconnected")


	# warning-ignore:return_value_discarded
	GamePad.connect("gamepad_button_pressed", self, "_on_GamePad_button_pressed")
	# warning-ignore:return_value_discarded
	GamePad.connect("gamepad_button_released", self, "_on_GamePad_button_released")

	# Allow controllers to get connected
	if (not OS.has_feature("standalone")) and DISABLE_SEARCH:
		print_debug("WARNING: Network controllers disabled while testing. Set DISABLE_SEARCH to " +
		"False to modify this behaviour ")
	else:
		GamePad.search_for_controllers()
		print_debug("WARNING: Network controllers are enabled manually. Set DISABLE_SEARCH to " +
		"True when comitting")

func _on_GamePad_controller_connected(id):
#	for i in range(0, 50):
#		controller_manager.new(GamePadController.new(controller_manager, i))
	print_debug("Network GamePad connected (id = " + str(id) + ")")

	# Add the controller to the manager
	controller_manager.add_controller(GamePadController.new(controller_manager, id))

func _on_GamePad_controller_disconnected(id):
	print_debug("Network GamePad DISCONNECTED (id = " + str(id) + ")")
	controller_manager.remove_controller(id)


func change_to_saladeespera():
	_change_screen(WaitingRoomResource)

func change_to_courses():
	_change_screen(CourseSelectionScreenResource)

func change_to_menu():
#	_change_screen(MenuResource)
	get_tree().reload_current_scene()

func _change_screen(target_screen_resource):
	current_scene_container.get_child(0).queue_free()
	current_scene_container.add_child(target_screen_resource.instance())


func _input(event):
	if controller_manager.input_keyboard(event):
		get_tree().set_input_as_handled()

func _on_GamePad_button_pressed(button, id):
	# print("id: " + String(id) + " pressed: " + String(button) + " received")
	controller_manager.input_gamepad(id, button, true)


func _on_GamePad_button_released(button, id):
	# print("id: " + String(id) + " released: " + String(button) + " received")
	controller_manager.input_gamepad(id, button, false)
