extends Camera2D

# La cámara comienza parada (speed = 0) hasta que un jugador atraviesa la puerta
# y a partir de entonces se mueve con una velocidad mínima de base_speed. Esta
# velocidad se incrementa si la coordenada x media de los jugadores es superior
# al acceleration_threshold_position_x. La aceleración es directamente proporcional
# a la distancia al treshold. Todas las posiciones x del script están expresadas
# considerando como origen de la coordenada x en el borde izquierdo de la pantalla.

# TODO: Fijar zoom de la cámara en (1, 1).

var speed : int
var base_speed := 150
# Factor máximo por el que se multiplicará la velocidad de la cámara.
var max_camera_speed_multiplier := 4
# Valor definido más adelante.
var acceleration_threshold_position_x
# Lista que contiene las posiciones_y medias del suelo en cada punto x del tilemap 
var _alturas_medias_tilemap := []
# Lista que contiene las posiciones_y medias que debe recorrer la cámara en cada tile
var alturas_medias_camara := []


func _ready():
	# La cámara se acelerará si la coordenada x media de los jugadores es mayor que
	# acceleration_threshold_position_x el cual ahora mismo es un tercio del ancho
	# de la pantalla.
	acceleration_threshold_position_x = get_viewport_rect().size.x / 3
	speed = 0
	scale = zoom

func _process(delta):
	position.x += speed * delta * get_camera_speed_multiplier()
	#if position.x >= 1280:
	#	position.y = 672 + alturas_medias_camara[floor(position.x/1280)] * 16

# Devuelve un valor entre 1 y max_camera_speed_multiplier en función de la posición
# media de los jugadores.
func get_camera_speed_multiplier():
	if get_parent().players.size() == 0:
		return 1 # Multiplicador base.
	var players_average_x = 0
	for player in get_parent().players:
		players_average_x += player.values()[0].global_position.x # Sumatorio de las posiciones globales.
	players_average_x /= get_parent().players.size() # Media de las posiciones globales.
	# Media de las posiciones globales tomando el origen de coordenadas definido arriba.
	var screen_players_average_x = players_average_x - self.position.x + get_viewport_rect().size.x / 2
	if screen_players_average_x <= acceleration_threshold_position_x:
		return 1 # Multiplicador base.
	else:
		var camera_speed_multiplier = (max_camera_speed_multiplier - 1) * ((screen_players_average_x - acceleration_threshold_position_x)/(get_viewport_rect().size.x - acceleration_threshold_position_x))
		return 1 + camera_speed_multiplier

# Devuelve una lista con la altura y que debe tener la cámara en cada punto.
# Esta altura es la media de las posiciones y del tilemap que ve la cámara en cada punto.
# Unidades expresadas en celdas
func get_camera_average_y_values():
	var camera_width_in_cells := 1280 / 16 # TODO: Resolver este cálculo en tiempo de ejecución
	var resultados := []
	for pos_x in range(_alturas_medias_tilemap.size() / 16):
		var coordenadasy_medias := []
		for x in range(-camera_width_in_cells/2, camera_width_in_cells/2 + 1):
			var y = _alturas_medias_tilemap[pos_x + x]
			if y != null and pos_x + x >= 0:
				# FIXME: La función nunca pasa de este if
				coordenadasy_medias.append(_alturas_medias_tilemap[pos_x + x])
		var sum : int
		for y in coordenadasy_medias:
			sum += y
		resultados.append(sum / coordenadasy_medias.size())
	return resultados

func _on_Tilemap_2_0_tilemap_generated():
	_alturas_medias_tilemap = get_node("/root/Main/CurrentScene/Node2D/Tilemap 2_0").calcular_y_media()
