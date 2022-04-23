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
const TICK_TIME = .5 # En segundos
const FAST_SCORE_BONUS = 5
# La función de puntos por supervivencia es https://www.geogebra.org/graphing/jpa3mcup
const TICKS_ALIVE_FOR_BONUS = 20
const ALIVE_BASE_BONUS = 5
const SCORE_LOST_ON_DEATH = .2 # En fracción

var player_list : Array
onready var rect_list = $VBoxContainer.get_children()
onready var waiting_room = owner

func _ready():
	waiting_room.connect("player_added", self, "_add_player")
	waiting_room.connect("player_removed", self, "_remove_player")
	waiting_room.connect("player_killed", self, "_on_player_killed")
	waiting_room.connect("run_started", self, "_start_timer")
	waiting_room.connect("run_ended", self, "_stop_timer")
	$Timer.wait_time = TICK_TIME
	$Timer.connect("timeout", self, "_timer_ticked")

func _add_player(body):
	var temp_player_dict = {
		body = null, # Player
		score = 0,
		wins = 0, # Veces que ha llegado primero a la meta
		deaths = 0,
		ticks_alive = 0
	}
	temp_player_dict.body = body
	player_list.append(temp_player_dict)
	_update_scoreboard()

func _remove_player(body):
	for player_dict in player_list:
		if player_dict.body == body:
			player_list.erase(player_dict)
			_update_scoreboard()
			return

func _on_player_killed(body):
	for player_dict in player_list:
		if player_dict.body == body:
			player_dict.score = int(player_dict.score * (1 - SCORE_LOST_ON_DEATH))
			player_dict.ticks_alive = 0
			player_dict.deaths += 1
			_update_scoreboard()
			return

func _start_timer():
	$Timer.start()

func _stop_timer():
	$Timer.stop()

func _sort_scores(a, b):
	return not a.score <= b.score

func _update_scoreboard():
	player_list.sort_custom(self, "_sort_scores")
	var total_score : int
	for player_dict in player_list:
		total_score += player_dict.score
	print(total_score)
	for i in range(min(player_list.size(), MAX_VISIBLE_PLAYERS)):
		var colored = rect_list[i].get_node("Colored")
		var other = rect_list[i].get_node("Other")
		other.visible = true
		colored.modulate = player_list[i].body.modulate
		colored.get_node("Bar").color.a = .8
		colored.get_node("Border").border_color.a = 1
		colored.get_node("Background").color.a = .3
		colored.get_node("Label BG").color = Color.darkgray
		if total_score != 0:
			colored.get_node("Bar").rect_size.x = $VBoxContainer.rect_size.x * player_list[i].score / total_score
		else:
			colored.get_node("Bar").rect_size.x = $VBoxContainer.rect_size.x
		other.get_node("Deaths").text = str(player_list[i].deaths)

func _timer_ticked():
	var fastest_player_dict = player_list[0]
	for player_dict in player_list:
		if player_dict.body.global_position.x > fastest_player_dict.body.global_position.x and player_dict != fastest_player_dict:
			fastest_player_dict = player_dict
		
		player_dict.ticks_alive += 1
		if player_dict.ticks_alive % TICKS_ALIVE_FOR_BONUS == 0:
			player_dict.score += int(ALIVE_BASE_BONUS + pow(ALIVE_BASE_BONUS, 3) * log(player_dict.ticks_alive / TICKS_ALIVE_FOR_BONUS))
	
	fastest_player_dict.score += FAST_SCORE_BONUS
	_update_scoreboard()
