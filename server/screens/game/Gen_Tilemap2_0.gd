extends Node2D

const FLOOR_CELL_ID = 2	# id del tipo de loseta que se usará para el suelo

var noise = OpenSimplexNoise.new()

func _ready():
	randomize()
	
	_anhade_suelo($TileMap, 1000, 3, 0, -3)
	#_create_hueco(1000,5,0,0)
	#_create_rampa(100,5,0,10)
	
#func _process(delta):
#		_move_camera()
#		pass

# Añade a tilemap un suelo de ancho width y de profundidad height a partir de la posición (pox_x, pos_y)
func _anhade_suelo(tilemap, width, height, pos_x , pos_y):
	for x in range(width):
		for y in range(height):
			tilemap.set_cellv(Vector2(pos_x + x, pos_y + y), FLOOR_CELL_ID)
	tilemap.update_bitmask_region()

func _create_hueco(width,height,pos_x,pos_y):#crea huecos en el suelo
	var distance_entre_huecos = 0
	var width_huecos = 0
	var final_pos_huecos = 0
	distance_entre_huecos = 16 #randi()%10+20
	width_huecos = randi()%5+5
	for x in range(width):
		for y in range(height):
			if x < 15:
				pass
#			elif abs((pos_x+x)%(distance_entre_huecos)) < width_huecos+1:
#				if abs((pos_x+x)%distance_entre_huecos) == width_huecos:
#						final_pos_huecos = pos_x+x
#						distance_entre_huecos = randi()%10+10
#						width_huecos = randi()%5+5
#						print("hola")
			elif x == (distance_entre_huecos+final_pos_huecos):
				#if abs(pos_x+x) == width_huecos :
				final_pos_huecos = x
				distance_entre_huecos = randi()%10+10
				width_huecos = randi()%5+5
				print("hola")
				$TileMap.set_cellv(Vector2(pos_x+x, pos_y+y), 1)
	
func _create_rampa(width,height,pos_x,pos_y):#crea rampas en el suelo
	for x in range(width):
		for y in range(height):
			$TileMap.set_cellv(Vector2(pos_x+x, pos_y+y), 2)
	
	$TileMap.update_bitmask_region()

#func _move_camera():
#	$Camera2D.move_local_x(2,true)
