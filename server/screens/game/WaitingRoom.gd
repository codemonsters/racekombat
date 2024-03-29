extends Node2D

var players : Array
var player_id := 0
var bodies_in_door = []
var bodies_in_exit = []
var death_queue = []
var perma_death = []

var CourseResource
var rng = RandomNumberGenerator.new()
var playing = false

const PlayerResource = preload("res://screens/game/player/Player.tscn")
# Lista que utilizaremos para dar un tinte distinto a cada jugador
const player_colors = [Color("FF7400"), Color("FFFF00"), Color("d65555"), Color("00DC00"), Color("634191"), Color("00B9B9"), Color("ffe7d6"), Color("")]

signal player_added
signal player_removed
signal player_killed
signal run_started
signal run_ended
signal flag_taken
signal change_to_menu


func _ready():
	rng.randomize()
	CourseResource = load(get_parent().get_parent().CourseResource)
	MusicManager.WaitingRoomMusicPlay()
	var course = CourseResource.instance()
	course.position = Vector2(1216, 609)
	add_child(course)
	$Camera2D._on_Tilemap_2_0_tilemap_generated()
	$"CanvasLayer/Progress Bar".on_Tilemap_2_0_tilemap_generated()
	_create_meta($Meta)
	$Meta.set_deferred("monitoring", false)
	$Respawner.connect("timeout", self, "_try_to_respawn_player")
	$LimiteExit.set_deferred("monitoring", true)
	connect("change_to_menu", get_tree().root.get_node("Main"), "change_to_menu")



func controller_input(_controller, action, _is_main, is_pressed):
	var player_found := false
	var player_index : int # Posición del jugador en la lista
	for i in players.size():
		if _controller in players[i].keys():
			player_found = true
			player_index = i
			break
	#
	if not player_found and playing:
		return
	elif not player_found: # Si el controlador no tiene un jugador asignado, lo creamos
		var new_player = PlayerResource.instance()
		new_player.position = Vector2(152, 400)
		new_player.modulate = player_colors[players.size() % player_colors.size()]
		add_child(new_player)
		players.append({_controller: new_player})
		emit_signal("player_added", new_player)
		new_player._handle_input(action, is_pressed) # Pasamos input inicial
	else: # Como tiene jugador asignado, le pasamos el input
		var active_player = players[player_index][_controller]
		active_player._handle_input(action, is_pressed)


func player_disconnect(_controller):
	for player in players:
		if player.keys()[0] == _controller:
			print_debug("Controller disconnected, removing player from game")
			emit_signal("player_removed", player.values()[0])
			player.values()[0].queue_free()
			players.erase(player)

		SfxManager.PlayerSpawnSound()


func _on_Limite_body_entered(body):
	playing = true
	$Limite.set_deferred("monitoring", false)
	$Meta.set_deferred("monitoring", true)
	$Camera2D.speed = $Camera2D.base_speed
	$"CanvasLayer/Progress Bar".visible = true
	GamePad.stop_search_for_controllers()
	emit_signal("run_started")
	MusicManager.UnmuffleMusic()
	SfxManager2.CourseEnter()
	yield(get_tree().create_timer(3.0),"timeout")
	$Camera2D/KillArea.set_deferred("monitoring", true)
	$Camera2D/KillArea.visible = true
	$Camera2D/KillArea/AnimatedSprite.set_animation("default")

func _on_LimiteExit_body_entered(body):
	emit_signal("change_to_menu")

# warning-ignore:integer_division
func _on_DoorOpeningArea_body_entered(body):
	bodies_in_door.append(body)
	if bodies_in_door.size() >= floor(players.size() / 2) + 1:
		$Door.open()


func _on_DoorOpeningArea_body_exited(body):
	bodies_in_door.erase(body)
# warning-ignore:integer_division
	if bodies_in_door.size() < floor(players.size() / 2) + 1 && bodies_in_door.size() == 0:
		$Door.close()

# warning-ignore:integer_division
func _on_ExitOpeningArea_body_entered(body):
	bodies_in_exit.append(body)
	if bodies_in_exit.size() >= floor(players.size() / 2) + 1:
		$Exit.open()


func _on_ExitOpeningArea_body_exited(body):
	bodies_in_exit.erase(body)
# warning-ignore:integer_division
	if bodies_in_exit.size() < floor(players.size() / 2) + 1 && bodies_in_door.size() == 0:
		$Exit.close()


func _create_meta(area): #Crea la meta con su posición x e y
	area.position.x = $"Tilemap 2_0".MAP_LENGTH * 32 + 1280 # El primer valor en ambas operaciones indica la posición (x,y)
	area.position.y = -10 * 32 + 720 # no cambiar: [* 32 + 1280] o [* 32 + 720]
	area.scale.y = max(-$"Tilemap 2_0".MIN_ALTURA, $"Tilemap 2_0".MAX_ALTURA) * 32 * 4
	# NOTA: Esto de la escala es mejorable, estamos ampliando la escala y, para evitar problemas, lo 
	# multiplicamos por cuatro y maloserá que no funcione.
	# TODO: si peta la meta, mirar aquí :s


func _on_Meta_body_entered(body):
	for player in players:
		if player.values()[0] == body:
			$Meta.set_deferred("monitoring", false)
			emit_signal("flag_taken", player.values()[0]) # Envía al ganador
			_disable_players()
			yield(get_tree().create_timer(1.0), "timeout")
			_teleport_to_waiting_room()


func _disable_players():
	for player in players:
		player.values()[0].enabled = false


func _teleport_to_waiting_room():
	playing = false
	$Limite.set_deferred("monitoring", true)
#	$LimiteExit.set_deferred("monitoring", true)
	$Camera2D.position = Vector2(640, 360)
	$Camera2D.speed = 0
	$Camera2D/KillArea.set_deferred("monitoring", false)
	$Camera2D/KillArea/AnimatedSprite.set_animation("start")
	$"CanvasLayer/Progress Bar".visible = false
	$"Tilemap 2_0"._create_tilemap()
	for player in players:
		_kill_player(player.values()[0])
		yield(get_tree().create_timer(0.5), "timeout")
		player.values()[0].enabled = true
	GamePad.search_for_controllers()
	emit_signal("run_ended")


func _unhandled_input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		_teleport_to_waiting_room()

func search_player_from_body(body):
	for player in players:
		if player.values()[0] == body:
			return player.values()[0]

func _on_KillArea_body_entered(body):
	_kill_player(search_player_from_body(body))


func _on_KillAreaFloor_body_entered(body):
	_kill_player(search_player_from_body(body))


func _on_KillAreaLeft_body_entered(body):
	_kill_player(search_player_from_body(body))


func _on_KillAreaRight_body_entered(body):
	_kill_player(search_player_from_body(body))


func _on_KillAreaTop_body_entered(body):
	_kill_player(search_player_from_body(body))

# Para evitar repetición en las KillAreas
func _kill_player(player):
	if player != null and player.get_node("Player SM").state.name != "Dead":
		player.enabled = false
		player.get_node("Player SM").transition_to("Dead")
		emit_signal("player_killed", player)
		death_queue.append(player)
		if $Respawner.is_stopped():
			$Respawner.start()

func _try_to_respawn_player():
	if death_queue.size() > 0:
		var dead_player: RigidBody2D = death_queue[0]
		var respawn_pos: Vector2 = $"Camera2D".global_position - Vector2(rng.randi_range(-50, 100), rng.randi_range(-50, 100))
		
		if respawn_pos.x >= ($Meta.position.x - 200): # No respawnear después de la meta
			death_queue.pop_front()
			perma_death.append(dead_player)
			return

		dead_player.enabled = true
		dead_player.get_node("Player SM").transition_to("Idle")
		dead_player.global_position = respawn_pos
		death_queue.pop_front()
	elif players.size() == perma_death.size(): # Todos los jugadores están perma-muertos
		death_queue = perma_death
		perma_death = []
		$Meta.set_deferred("monitoring", false)
		_disable_players()
		_teleport_to_waiting_room()
	else:
		$Respawner.stop()
