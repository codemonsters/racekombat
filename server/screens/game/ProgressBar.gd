extends Control

onready var camera = owner.get_node("Camera2D")
onready var OFFSET = owner.get_node("Limite").global_position.x
const WIDTH = 1280 - 150 * 2
const MAP_WIDTH = 500 * 32 # Debería acceder al tilemap y sacarlo de ahí
const RECT_SIZE = 20

func _ready():
	visible = false
	$Background.rect_size.x = WIDTH
	$Bar.rect_size.x = 0
	$Background.rect_size.y = RECT_SIZE
	$Bar.rect_size.y = RECT_SIZE
	
	$Border.rect_size.x = WIDTH + (RECT_SIZE/2)
	$Border.rect_position.x = -(RECT_SIZE/4)
	$Border.rect_size.y = RECT_SIZE * 1.5
	$Border.rect_position.y = -(RECT_SIZE/4)

func _process(_delta):
	$Bar.rect_size.x = WIDTH * ((camera.global_position.x - OFFSET) / MAP_WIDTH)
