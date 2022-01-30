extends Node2D

var players : Array
var player_id := 0
var bodies_in_door = []

const PlayerResource = preload("res://screens/game/player/Player.tscn")

func _ready():
	WaitingRoomMusic.WaitingRoomMusicPlay()

func controller_input(_controller, action, _is_main, is_pressed):
	var player_found := false
	var player_index : int # Posición del jugador en la lista
	for i in players.size():
		if _controller in players[i].keys():
			player_found = true
			player_index = i
			break
	#
	if player_found: # Si el controlador tiene un jugador asignado, le pasamos su input
		var active_player = players[player_index][_controller]
		active_player._handle_input(action, is_pressed)
	elif action == "action" and not is_pressed: # Si el controlador no tiene un jugador asignado y se pulsa y se suelta "acción", le asignamos el jugador
		var new_player = PlayerResource.instance()
		new_player.position = Vector2(300, 300)
		add_child(new_player)
		players.append({_controller: new_player})
	else:
		var active_player = players[controller_index][_controller]
		active_player._handle_input(action, is_pressed)

func player_disconnect(_controller):
	for player in players:
		if player.keys()[0] == _controller:
			print_debug("Controller disconnected, removing player from game")
			player.values()[0].queue_free()
			players.erase(player)
    
		PlayerAppear.PlayerSpawnSound()


func _on_Limite_body_entered(body):
	print("sfsdghvbuxdf")
	PlayerStart.PlayerStartSound()


func _on_DoorOpeningArea_body_entered(body):
	bodies_in_door.append(body)
	$Door.open()


func _on_DoorOpeningArea_body_exited(body):
	bodies_in_door.erase(body)
	$Door.close()