extends Node2D

const FLOOR_CELL_ID = 2	# id del tipo de loseta que se usará para el suelo

var noise = OpenSimplexNoise.new()

func _ready():
	randomize()
	
	_anhade_suelo($TileMap, 200, 3, 0, -3)
	_create_hueco($TileMap, 200, 3, 0, -3)
	_create_rampa($TileMap, 200, 3, 0, -3)
	
# Añade a tilemap un suelo de ancho width y de profundidad height a partir de la posición (pox_x, pos_y)
func _anhade_suelo(tilemap, width, height, pos_x , pos_y):
	for x in range(width):
		for y in range(height):
			tilemap.set_cellv(Vector2(pos_x + x, pos_y + y), FLOOR_CELL_ID)
	tilemap.update_bitmask_region()

func _create_hueco(tilemap, width, height, pos_x, pos_y):#Crea huecos en el suelo
	var distance_entre_huecos = 0 #Distancia entre los huecos
	var width_huecos = 0 #Ancho de los huecos
	var final_pos_huecos = 0
	var bloques_en_final = 30 #Bloques que hay en la plataforma final
	distance_entre_huecos = randi()%10+20 #Distance huecos coge valores entre 10 y 30
	width_huecos = randi()%12+10 #Width huecos coge valores entre 10 y 22
	while((final_pos_huecos+distance_entre_huecos) < width - bloques_en_final):
		for x in range(final_pos_huecos + distance_entre_huecos, final_pos_huecos + distance_entre_huecos + width_huecos):
			for y in range(height):
					if x == final_pos_huecos + distance_entre_huecos + width_huecos - 1:
							final_pos_huecos = pos_x+x
							#Se reinician los valores
							distance_entre_huecos = randi()%30+20 
							width_huecos = randi()%12+10 
					tilemap.set_cellv(Vector2(pos_x+x, pos_y+y), 1)
	tilemap.update_bitmask_region()
	

func _create_rampa(tilemap,width,height,pos_x,pos_y):#Crea rampas en el suelo
	pass #TODO Crear algoritmo rampas 1º idea copiar el de los huecos
	tilemap.update_bitmask_region()


