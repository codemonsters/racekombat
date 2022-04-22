extends Node2D

# El jugador que llegue primero a la meta tendrá una corona o similar en la siguiente carrera.
# Además, en función del tiempo que cada jugador ha estado a la delantera o demás condiciones
# pueden obtener puntos. El jugador con más puntos tendrá otro cosmético u otra recompensa.

# En la esquina superior derecha aparecen bloques con la información de los jugadores que van mejor,
# esto es: sus victorias, sus muertes, etc., y de fondo un relleno que indica su "potencial" de puntos
# en la carrera. Es decir, si van muy adelantados o si han muerto poco, este potencial será mayor.
# También se debe poder saber cómo de avanzados están respecto al resto en el trayecto.
# La información del resto de los jugadores aparecerá en barras simples de su color, de tamaño mucho
# más reducido, para que puedan saber en que puesto están.

# Cada tick del temporizador se evalúan los puntos a otorgar. En todos los ticks, la persona que esté
# más adelantada gana puntos. Cada varios ticks los jugadores que no hayan muerto en un tiempo considerable
# ganan puntos; los puntos ganados también aumentan con el tiempo, similar a una exponencial menos inclinada.

const MAX_VISIBLE_PLAYERS = 3
const TICK_TIME = .5
const FAST_SCORE_BONUS = 5

var player_list : Array
onready var rect_list = $VBoxContainer.get_children()
onready var waiting_room = get_parent().get_parent()

func _ready():
	waiting_room.connect("player_added", self, "_add_player")
	waiting_room.connect("run_started", self, "_start_timer")
	$Timer.wait_time = TICK_TIME
	$Timer.connect("timeout", self, "_timer_ticked")

func _add_player():
	player_list.append(waiting_room.players[-1].values()[0])

func _start_timer():
	$Timer.start() #TODO: revisar y añadir pausa al terminar la carrera

func _sort_scores(a, b):
	if a.score <= b.score:
		return false
	else:
		return true

func _process(_delta):
	player_list.sort_custom(self, "_sort_scores")
	if player_list.size() > 0:
		for i in range(min(player_list.size(), MAX_VISIBLE_PLAYERS)):
			rect_list[i].color = player_list[i].modulate
			rect_list[i].color.a = .5

func _timer_ticked():
	var fastest_player = player_list[0]
	for player in player_list:
		if player.global_position.x > fastest_player.global_position.x:
			fastest_player = player
	fastest_player.score += FAST_SCORE_BONUS
