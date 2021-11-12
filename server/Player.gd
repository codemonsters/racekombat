extends KinematicBody2D

var velocity = Vector2()
var velocidad = 300
var gravedad = 800
var velocidadSalto = -400

func _ready():
	pass

func _process(delta):
	print(get_node("Player SM").state.name)
