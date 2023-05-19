extends Control

const SERVER_PORT = 31416
const MAX_PLAYERS = 4

#var ip_address = '192.168.1.208'
var host_ip_address = null
var _id = null
var connected = false
var layout_dict = {}
var color = "#151b29"

var disconnecting = false

func _ready():
# warning-ignore:return_value_discarded
	get_tree().connect("connected_to_server", self, "on_connected_to_server")
# warning-ignore:return_value_discarded
	get_tree().connect("connection_failed", self, "on_connection_failed")
# warning-ignore:return_value_discarded
	get_tree().connect("server_disconnected", self, "on_server_disconnected")


func join_server():
	if host_ip_address:
		var host = NetworkedMultiplayerENet.new()
		var ERR = host.create_client(host_ip_address, SERVER_PORT)
		get_tree().set_network_peer(host)

		if ERR == OK:
			return true
		else:
			return false
	else:
		print('No Host IP Adress')

func disconnect_server():
	get_tree().set_network_peer(null)
	print('Disconnecting From Server')
	connected = false
	disconnecting = true
	get_tree().change_scene("res://JoinServer/JoinServerControl.tscn")
	VisualServer.set_default_clear_color(Color("#151b29"))

func on_connected_to_server():
	print('Connected To Server')
	VisualServer.set_default_clear_color(color)
	connected = true


func on_connection_failed():
	print('connection failure')


func on_server_disconnected():
	print('Disconnected From Server')
	connected = false
	disconnecting = true
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://JoinServer/JoinServerControl.tscn")
