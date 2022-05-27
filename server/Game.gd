extends Node2D


var controller_manager: ControllersManager
const DISABLE_SEARCH = false # INFO: Set to false to connect controllers *while debugging*
# var players = {}

onready var current_scene_container = get_node("CurrentScene")
onready var WaitingRoomResource = preload("res://screens/game/WaitingRoom.tscn")
onready var MenuResource = preload("res://screens/menu/Menu.tscn")
onready var CourseScreenResource = preload("res://screens/menu/CourseScreen.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	controller_manager = ControllersManager.new(self)
	controller_manager.add_controller(KeyboardController.new(controller_manager,
		KEY_W, KEY_S, KEY_A, KEY_D, KEY_V, KEY_B)
	)
	controller_manager.add_controller(KeyboardController.new(controller_manager,
		KEY_UP, KEY_DOWN, KEY_LEFT, KEY_RIGHT, KEY_N, KEY_M)
	)
	
	# Añadidos solo para hacer pruebas en las que se necesitan muchos jugadores
#	controller_manager.add_controller(KeyboardController.new(controller_manager,
#		KEY_T, KEY_Y, KEY_U, KEY_I, KEY_O, KEY_P)
#	)
#	controller_manager.add_controller(KeyboardController.new(controller_manager,
#		KEY_F, KEY_G, KEY_H, KEY_J, KEY_K, KEY_L)
#	)
	
	# Conecta la señal con la función. La hay que asignar a una variable pq sino 
	# lanza un warning :S
	var _im_just_trash = $CurrentScene/Menu.connect("change_to_saladeespera", self,
									   "change_to_saladeespera")
	
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
	print("Network GamePad connected (id = " + str(id) + ")")

	# Add the controller to the manager
	controller_manager.add_controller(GamePadController.new(controller_manager, id))

func _on_GamePad_controller_disconnected(id):
	print("Network GamePad DISCONNECTED (id = " + str(id) + ")")
	controller_manager.remove_controller(id)


func change_to_saladeespera():
	_change_screen(WaitingRoomResource)


func change_to_courses():
	_change_screen(CourseScreenResource)


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
