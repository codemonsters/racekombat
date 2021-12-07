extends Node2D

var amplitud
export var radio = Vector2(100, 100)
export var ancho_plataforma = 100
export var izquierda = false
var angulo
var k = 1
var v = 1
onready var plataforma = get_node("Plataforma")

func _ready():
	amplitud = PI + 2*(radio.angle_to(Vector2.RIGHT))
	if izquierda:
		angulo = amplitud
	else:
		angulo = 0
	plataforma.get_node("ColorRect").rect_size = Vector2(ancho_plataforma, 20)
	plataforma.get_node("CollisionShape2D").shape.extents = Vector2(ancho_plataforma/2, 10)
	plataforma.get_node("CollisionShape2D").position = Vector2(ancho_plataforma/2, 10)
	plataforma.position = -Vector2(ancho_plataforma/2, 0)

func _process(delta):
	if angulo >= amplitud:
		k = -1
	elif angulo <= 0:
		k = 1
	v = 1.25 - (abs((amplitud/2) - angulo)/(amplitud/2))
	angulo += delta * k * v
	plataforma.position = radio.rotated(angulo) - Vector2(ancho_plataforma/2, 0)
	update() # Para llamar a _draw()

func _draw():
	draw_line(Vector2(0,0), plataforma.position + Vector2(ancho_plataforma/2, 10), Color(255, 0, 0), 5)
