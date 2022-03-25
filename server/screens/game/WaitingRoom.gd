extends Node2D

var players : Array
var player_id := 0
var bodies_in_door = []

const PlayerResource = preload("res://screens/game/player_new/Player.tscn")

func _ready():
	MusicManager.WaitingRoomMusicPlay()
	_create_meta($Meta)

func controller_input(_controller, action, _is_main, is_pressed):
	var player_found := false
	var player_index : int # Posición del jugador en la lista
	var controller_index : int
	for i in players.size():
		if _controller in players[i].keys():
			player_found = true
			player_index = i
			break
	#
	if not player_found: # Si el controlador no tiene un jugador asignado, lo creamos
		var new_player = PlayerResource.instance()
		new_player.position = Vector2(300, 300)
		add_child(new_player)
		players.append({_controller: new_player})
		new_player._handle_input(action, is_pressed) # Pasamos input inicial
	else: # Como tiene jugador asignado, le pasamos el input
		var active_player = players[player_index][_controller]
		active_player._handle_input(action, is_pressed)


func player_disconnect(_controller):
	for player in players:
		if player.keys()[0] == _controller:
			print("Controller disconnected, removing player from game")
			player.values()[0].queue_free()
			players.erase(player)
	
		SfxManager.PlayerSpawnSound()


func _on_Limite_body_entered(body):
	$Camera2D.speed = $Camera2D.base_speed
	SfxManager.PlayerStartSound()
	yield(get_tree().create_timer(3.0),"timeout")
	$Camera2D/KillArea.monitoring = true
	$Camera2D/KillArea.visible = true
	GamePad.stop_search_for_controllers()


func _on_DoorOpeningArea_body_entered(body):
	print(floor(players.size() / 2) + 1)
	bodies_in_door.append(body)
	if bodies_in_door.size() >= floor(players.size() / 2) + 1:
		$Door.open()


func _on_DoorOpeningArea_body_exited(body):
	bodies_in_door.erase(body)
	if bodies_in_door.size() < floor(players.size() / 2) + 1 && bodies_in_door.size() == 0:
		$Door.close()


func _on_KillArea_body_entered(body):
	for player in players:
		if player.values()[0] == body:
			player_disconnect(player.keys()[0])

func _create_meta(area): #Crea la meta con su posición x e y
	area.position.x = get_parent().get_node("Node2D/Tilemap 2_0").MAP_LENGTH*16+1280 #Modificar solo el primer parámetro
	area.position.y = -10*16+720


func _on_Meta_body_entered(body):
	print("Llegaste a la meta")


func _on_KillAreaFloor_body_entered(body):
	for player in players:
		if player.values()[0] == body:
			player_disconnect(player.keys()[0])



func _on_KillAreaLeft_body_entered(body):
	for player in players:
		if player.values()[0] == body:
			player_disconnect(player.keys()[0])


func _on_KillAreaRight_body_entered(body):
	for player in players:
		if player.values()[0] == body:
			player_disconnect(player.keys()[0])


func _on_KillAreaTop_body_entered(body):
	for player in players:
		if player.values()[0] == body:
			player_disconnect(player.keys()[0])

