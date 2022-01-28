extends Node2D

var players : Array
var player_id := 0
var bodies_in_door = []

const PlayerResource = preload("res://screens/game/player/Player.tscn")

func _ready():
	WaitingRoomMusic.WaitingRoomMusicPlay()

func controller_input(_controller, action, _is_main, is_pressed):
	var found := false
	var controller_index : int
	for i in players.size():
		if _controller in players[i].keys():
			found = true
			controller_index = i
	if not found:
		var new_player = PlayerResource.instance()
		new_player.position = Vector2(300, 300)
		add_child(new_player)
		players.append({_controller: new_player})
		PlayerAppear.PlayerSpawnSound()
	else:
		var active_player = players[controller_index][_controller]
		active_player._handle_input(action, is_pressed)



func _on_Limite_body_entered(body):
	print("sfsdghvbuxdf")
	PlayerStart.PlayerStartSound()


func _on_DoorOpeningArea_body_entered(body):
	bodies_in_door.append(body)
	$Door.open()


func _on_DoorOpeningArea_body_exited(body):
	bodies_in_door.erase(body)
	$Door.close()
