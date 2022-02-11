extends Node2D

const FLOOR_CELL_ID = 2	# id del tipo de loseta que se usará para el suelo

var noise = OpenSimplexNoise.new()

func _ready():
	randomize()
	
	_anhade_suelo($TileMap, 100, 3, 0, -3)
	#_create_hueco($TileMap, 100, 3, 0, -3)
	_create_meta($Meta)
	#_create_rampa(100,5,0,10)
	
# Añade a tilemap un suelo de ancho width y de profundidad height a partir de la posición (pox_x, pos_y)
func _anhade_suelo(tilemap, width, height, pos_x , pos_y):
	for x in range(width):
		for y in range(height):
			tilemap.set_cellv(Vector2(pos_x + x, pos_y + y), FLOOR_CELL_ID)
	tilemap.update_bitmask_region()

func _create_hueco(tilemap, width, height, pos_x, pos_y):#crea huecos en el suelo
	var distance_entre_huecos = 0
	var width_huecos = 0
	var final_pos_huecos = 0
	distance_entre_huecos = randi()%10+10 #Distance huecos coge valores entre 10 y 20(10+10)
	width_huecos = randi()%5+5 #Width huecos coge valores entre 5 y 10(5+5)
	while((final_pos_huecos+distance_entre_huecos) < width):
		for x in range(final_pos_huecos + distance_entre_huecos, final_pos_huecos + distance_entre_huecos + width_huecos):
			for y in range(height):
					if x == final_pos_huecos + distance_entre_huecos + width_huecos - 1:
							final_pos_huecos = pos_x+x
							#Se reinician los valores
							distance_entre_huecos = randi()%10+10 #Distance huecos coge valores entre 10 y 20(10+10)
							width_huecos = randi()%5+5 #Width huecos coge valores entre 5 y 10(5+5)
					tilemap.set_cellv(Vector2(pos_x+x, pos_y+y), 1)
	tilemap.update_bitmask_region()

func _create_rampa(width,height,pos_x,pos_y):#crea rampas en el suelo
	for x in range(width):
		for y in range(height):
			$TileMap.set_cellv(Vector2(pos_x+x, pos_y+y), 2)
	
	$TileMap.update_bitmask_region()

func _create_meta(area): #Crea la meta con su posición x e y
	area.position.x = 1600 
	area.position.y = -160


func _on_Meta_body_entered(body):
	print("hola fin")
