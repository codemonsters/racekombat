extends Node

const colors = [Color("FF7400"), Color("FFFF00"), Color("d65555"), Color("00DC00"), Color("634191"), Color("00B9B9"), Color("ffe7d6"), Color("")]
const UDP_PORT = 4242

var server := UDPServer.new()
var is_broadcasting = false
var layout


func _ready():
	set_process(false)
	layout = UI_Builder.load_layout_info()


func _process(_delta):
# warning-ignore:return_value_discarded
	server.poll()
	if server.is_connection_available():
		var peer : PacketPeerUDP = server.take_connection()
		var pkt = peer.get_packet()
		var l = layout
		l["player_color"] = get_color(get_tree().get_rpc_sender_id())
		print(l["player_color"])
		print_debug(l)
		
#		print("Accepted peer: %s:%s" % [peer.get_packet_ip(), peer.get_packet_port()])
#		print("Received data: %s" % [pkt.get_string_from_utf8()])
		# Reply so it knows we received the message.
# warning-ignore:return_value_discarded
		print_debug(layout)
		peer.put_packet(JSON.print(layout).to_utf8())


func start_broadcast():
# warning-ignore:return_value_discarded
	server.listen(UDP_PORT)
	set_process(true)
	
	is_broadcasting = true
#	print('UDP Broadcast Started')


func stop_broadcast():
	server.stop()
	set_process(false)
	
	is_broadcasting = false
#	print('UDP Broadcast Stopped')


func get_color(id: int) -> Color:
	var v = 0
	for i in str(id):
		v += int(i)
	print_debug(v % len(colors), "------")
	return colors[v % len(colors)]
