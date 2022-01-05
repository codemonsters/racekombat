extends Node2D

var players : Array
var player_id := 0

const PlayerResource = preload("res://screens/game/player/Player.tscn")

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
	else:
		var active_player = players[controller_index][_controller]
		active_player._handle_input(action, is_pressed)
