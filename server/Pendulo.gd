extends Node2D

# ARREGLAR POSICION INICIAL
# SUAVIZAR MOVIMIENTO

var amplitud
export var radio = Vector2(300, 100)
export var ancho_plataforma = 100
var posicion_inicial = radio
var angulo
var k = 1
onready var plataforma = get_node("Plataforma")

func _ready():
	amplitud = PI + 2*(radio.angle_to(Vector2.RIGHT))
	angulo = 0
	posicion_inicial = Vector2(600, 400)
	plataforma.get_node("ColorRect").rect_size = Vector2(ancho_plataforma, 20)
	plataforma.position = posicion_inicial - Vector2(ancho_plataforma/2, 0)

func _process(delta):
	if angulo >= amplitud:
		k = -1
	elif angulo <= 0:
		k = 1
	angulo += delta * k
	plataforma.position = posicion_inicial + radio.rotated(angulo) - Vector2(ancho_plataforma/2, 0)
	update()

func _draw():
	draw_line(posicion_inicial, plataforma.position + Vector2(ancho_plataforma/2, 10), Color(255, 0, 0), 5)
