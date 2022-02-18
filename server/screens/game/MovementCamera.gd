extends Camera2D

# La cámara comienza parada (speed = 0) hasta que un jugador atraviesa la puerta
# y a partir de entonces se mueve con una velocidad mínima de base_speed. Esta
# velocidad se incrementa si la coordenada x media de los jugadores es superior
# al acceleration_threshold_position_x. La aceleración es directamente proporcional
# a la distancia al treshold. Todas las posiciones x del script están expresadas
# considerando como origen de la coordenada x en el borde izquierdo de la pantalla.

var speed : int
var base_speed := 150
# Factor máximo por el que se multiplicará la velocidad de la cámara.
var max_camera_speed_multiplier := 4
# Valor definido más adelante.
var acceleration_threshold_position_x 

func _ready():
	# La cámara se acelerará si la coordenada x media de los jugadores es mayor que
	# acceleration_threshold_position_x el cual ahora mismo es un tercio del ancho
	# de la pantalla.
	acceleration_threshold_position_x = get_viewport_rect().size.x / 3
	speed = 0

func _process(delta):
	position.x += speed * delta * get_camera_speed_multiplier()

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
