extends Node2D


var controller_manager: ControllersManager
var players = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	controller_manager = ControllersManager.new(self)
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

	# warning-ignore:return_value_discarded
	GamePad.connect("gamepad_connected", self, "_on_GamePad_controller_connected")
	# warning-ignore:return_value_discarded
	GamePad.connect("gamepad_disconnected", self, "_on_GamePad_controller_disconnected")
	# Allow controllers to get connected
	GamePad.search_for_controllers()

func _on_GamePad_controller_connected(id):
	print("Network GamePad connected (id = " + str(id) + ")")
	var player_name
	var values = []
	for player in players:
		values.append(players.get(player))
		
	for i in range(1, 4):
		var test_player = "player %s" % str(i)
		if !test_player in values:
			player_name = test_player
			break
	players[id] = player_name
	
	#var new_player_display = PlayerDisplay.instance()
	#new_player_display.player_name = player_name
# warning-ignore:return_value_discarded
	#connect("player_disconnected", new_player_display, "_on_player_disconnected")
	#add_child(new_player_display)


func _on_GamePad_controller_disconnected(id):
	print("Network GamePad DISCONNECTED (id = " + str(id) + ")")

	print(players)
	emit_signal("player_disconnected", players.get(id))
	players.erase(id)
	print(players)


func change_to_saladeespera():
	get_node("CurrentScene/Menu").queue_free()
	var current_scene_container = get_node("CurrentScene")
	var sala_de_espera = preload("res://screens/game/WaitingRoom.tscn")
	current_scene_container.add_child(sala_de_espera.instance())


func _input(event):
	if controller_manager.input(event):
		get_tree().set_input_as_handled()
