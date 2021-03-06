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

const ScoreBarResource = preload("res://screens/game/Score Bar.tscn")

const MAX_VISIBLE_PLAYERS = 3
const TICK_TIME = .5 # En segundos
const FAST_SCORE_BONUS = 5
# La función de puntos por supervivencia es https://www.geogebra.org/graphing/jpa3mcup
const TICKS_ALIVE_FOR_BONUS = 20
const ALIVE_BASE_BONUS = 5
const SCORE_LOST_ON_DEATH = .2 # En fracción

var player_list : Array
var total_score : int
onready var rect_list = $VBoxContainer.get_children()
onready var waiting_room = owner

func _ready():
	waiting_room.connect("player_added", self, "_add_player")
	waiting_room.connect("player_removed", self, "_remove_player")
	waiting_room.connect("player_killed", self, "_on_player_killed")
	waiting_room.connect("run_started", self, "_on_run_started")
	waiting_room.connect("run_ended", self, "_on_run_ended")
	waiting_room.connect("flag_taken", self, "_on_flag_taken")
	$Timer.wait_time = TICK_TIME
# warning-ignore:return_value_discarded
	$Timer.connect("timeout", self, "_timer_ticked")

func _add_player(body):
	var new_player_dict = {
		body = null, # Player
		score = 0,
		wins = 0, # Veces que ha llegado primero a la meta
		deaths = 0,
		ticks_alive = 0,
		score_bar = null
	}
	new_player_dict.body = body
	var new_score_bar = ScoreBarResource.instance()
	new_score_bar.manager = self
	new_score_bar.get_node("Colored").modulate = new_player_dict.body.modulate
	$VBoxContainer.add_child(new_score_bar)
	new_score_bar._update_other("deaths", 0)
	new_score_bar._update_other("wins", 0)
	new_score_bar._change_visibility("deaths", false)
	new_player_dict.score_bar = new_score_bar
	player_list.append(new_player_dict)
	_update_scores()

func _remove_player(body):
	for player_dict in player_list:
		if player_dict.body == body:
			for score_bar in $VBoxContainer.get_children():
				if score_bar == player_dict.score_bar:
					$VBoxContainer.remove_child(score_bar)
			player_list.erase(player_dict)
			_update_scores()
			return

func _on_player_killed(body):
	for player_dict in player_list:
		if player_dict.body == body:
			player_dict.score = int(player_dict.score * (1 - SCORE_LOST_ON_DEATH))
			player_dict.ticks_alive = 0
			player_dict.deaths += 1
			player_dict.score_bar._update_other("deaths", player_dict.deaths)
			_update_scores()
			return

func _on_run_started():
	for player_dict in player_list:
		player_dict.score_bar._change_visibility("ui", false)
		player_dict.score_bar._change_visibility("wins", false)
		player_dict.score_bar._change_visibility("deaths", true)
	$Timer.start()

func _on_run_ended():
	$Timer.stop()
	for player_dict in player_list:
		player_dict.score = 0
		player_dict.deaths = 0
		player_dict.score_bar._change_to_reduced_mode(false)
		player_dict.score_bar._update_other("deaths", player_dict.deaths)
		player_dict.score_bar._change_visibility("ui", true)
		player_dict.score_bar._change_visibility("wins", true)
		player_dict.score_bar._change_visibility("deaths", false)
		player_dict.ticks_alive = 0
	_update_scores()

func _on_flag_taken(body):
	for player_dict in player_list:
		if player_dict.body == body:
			player_dict.wins += 1
			player_dict.score_bar._update_other("wins", player_dict.wins)
			return

func _sort_scores(a, b):
	return not a.score <= b.score

func _update_scores():
	player_list.sort_custom(self, "_sort_scores")
	for i in range(player_list.size()):
		$VBoxContainer.move_child(player_list[i].score_bar, i)
	total_score = 0
	for player_dict in player_list:
		total_score += player_dict.score
	for player_dict in player_list: # No se me ocurre cómo hacerlo sin dos loops
		if not player_list.find(player_dict, 0) > MAX_VISIBLE_PLAYERS - 1:
			player_dict.score_bar._change_to_reduced_mode(false)
			player_dict.score_bar._update_score(player_dict.score, total_score)
		elif not $Timer.is_stopped():
			player_dict.score_bar._change_to_reduced_mode(true)
			player_dict.score_bar.target_position = player_list[MAX_VISIBLE_PLAYERS - 1].score_bar.get_node("Colored/Bar").rect_position.x

func _timer_ticked():
	var fastest_player_dict = player_list[0]
	for player_dict in player_list:
		if player_dict.body.global_position.x > fastest_player_dict.body.global_position.x and player_dict != fastest_player_dict:
			fastest_player_dict = player_dict
		
		player_dict.ticks_alive += 1
		if player_dict.ticks_alive % TICKS_ALIVE_FOR_BONUS == 0:
			player_dict.score += int(ALIVE_BASE_BONUS + pow(ALIVE_BASE_BONUS, 3) * log(player_dict.ticks_alive / TICKS_ALIVE_FOR_BONUS))
	
	fastest_player_dict.score += FAST_SCORE_BONUS
	_update_scores()
