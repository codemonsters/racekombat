extends Camera2D

# La cámara comienza parada (speed = 0) hasta que un jugador atraviesa la puerta
# y a partir de entonces se mueve con una velocidad mínima de base_speed. Esta
# velocidad se incrementa si la coordenada x media de los jugadores es superior
# al acceleration_threshold_position_x. La aceleración es directamente proporcional
# a la distancia al treshold. Todas las posiciones x del script están expresadas
# considerando como origen de la coordenada x en el borde izquierdo de la pantalla.

# TODO: Fijar zoom de la cámara en (1, 1).

var speed : int
var base_speed := 150 # DEBUG, era 150
# Factor máximo por el que se multiplicará la velocidad de la cámara.
var max_camera_speed_multiplier := 4
# Valor definido más adelante.
var acceleration_threshold_position_x
# Lista que contiene las posiciones_y medias del suelo en cada punto x del tilemap 
var _alturas_medias_tilemap := []
# Lista que contiene las posiciones_y medias que debe recorrer la cámara en cada tile
var alturas_medias_camara := []
# Altura que se le resta a la posicion_y media para que no se vea demasiado suelo
var altura_offset := 120
# Posicion_y hacia la que la cámara tenderá a moverse, sale de alturas_medias_camara
var target_y : int
# Velocidad máxima vertical a la que se desplaza la cámara para moverse hacia target_y suavemente
var y_max_speed := 70
# Variable en la que se almacena el Tilemap
var _tilemap
# Tamaño de los tiles
onready var tile_side : int 
# Tamaño de la cámara medido en tiles
onready var camera_width := get_viewport().size.x



func _ready():
	# La cámara se acelerará si la coordenada x media de los jugadores es mayor que
	# acceleration_threshold_position_x el cual ahora mismo es un tercio del ancho
	# de la pantalla.
	acceleration_threshold_position_x = get_viewport_rect().size.x / 3
	speed = 0
	scale = zoom


func _process(delta):
	# Comprueba que la cámara no se siga desplazándose hacia la derecha si no quedan más tiles
	if position.x - camera_width < alturas_medias_camara.size() * tile_side - tile_side:
		position.x += speed * delta * get_camera_speed_multiplier()
		if position.x >= camera_width: # Cuando atraviese la puerta de Waiting Room
			target_y = _tilemap.global_position.y - altura_offset + alturas_medias_camara[(position.x - camera_width) / tile_side] * tile_side
			if position.y < target_y:
				position.y += min(y_max_speed * delta, target_y - position.y)
			elif position.y > target_y:
				position.y -= min(y_max_speed * delta, position.y - target_y)


# Devuelve un valor entre 1 y max_camera_speed_multiplier en función de la posición
# media de los jugadores.
func get_camera_speed_multiplier():
	var valid_players = [] # Es decir, jugadores que no están muertos
	for player_dict in get_parent().players:
		var player = player_dict.values()[0]
		if not player.get_node("Player SM").state.name == "Dead":
			valid_players.append(player)
	if valid_players.size() == 0:
		return 1 # Multiplicador base.
	var players_average_x = 0
	var player_number = 0
	for valid_player in valid_players:
		players_average_x += valid_player.global_position.x # Sumatorio de las posiciones globales.
	players_average_x /= valid_players.size() # Media de las posiciones globales.
	# Media de las posiciones globales tomando el origen de coordenadas definido arriba.
	var screen_players_average_x = players_average_x - self.position.x + get_viewport_rect().size.x / 2
	if screen_players_average_x <= acceleration_threshold_position_x:
		return 1 # Multiplicador base.
	else:
		var camera_speed_multiplier = (max_camera_speed_multiplier - 1) * ((screen_players_average_x - acceleration_threshold_position_x)/(get_viewport_rect().size.x - acceleration_threshold_position_x))
		return 1 + camera_speed_multiplier


# Devuelve una lista con la altura "y" que debe tener la cámara en cada punto.
# Esta altura es la media de las posiciones y del tilemap que ve la cámara en cada punto.
# Unidades expresadas en celdas
func get_camera_average_y_values():
	var camera_width_in_cells := camera_width / tile_side # TODO: Resolver este cálculo en tiempo de ejecución
	var resultados := []
	for camera_x in range(_alturas_medias_tilemap.size()):
		var coordenadasy_medias := []
		for x in range(max(camera_x - camera_width_in_cells / 2, 0), min(camera_x + camera_width_in_cells / 2, _alturas_medias_tilemap.size() - 1)):
			var y = _alturas_medias_tilemap[x]
			if y != null:
				coordenadasy_medias.append(_alturas_medias_tilemap[x])
		var sum : int
		for y in coordenadasy_medias:
			sum += y
		resultados.append(sum / coordenadasy_medias.size())
	return resultados
	


func _on_Tilemap_2_0_tilemap_generated():
	_tilemap = get_node("/root/Main/CurrentScene/Waiting Room/Tilemap 2_0")
	tile_side = _tilemap.get_node("TileMap").cell_size.x
	_alturas_medias_tilemap = _tilemap.calcular_y_media()
#	yield(self, "ready")
	alturas_medias_camara = get_camera_average_y_values()
