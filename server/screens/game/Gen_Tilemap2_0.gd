extends Node2D

const MAP_LENGTH = 200	# longitud del mapa (en tiles)
const MAP_HEIGHT = -7 # altura del mapa (en tiles) un valor negativo hace que el mapa se genere hacia abajo y uno positivo que se genere hacia arriba
const FLOOR_CELL_ID = 2	# id del tipo de loseta que se usará para el suelo
const VACUM_CELL_ID = 1	# id del tipo de loseta que se usará para el vacío
const POS_X_INICIAL = 0
const POS_Y_INICIAL = 0 #Y esta invertida - es una pos_y mas alta y + una mas baja


const FACTOR_ALTO_MONTICULOS = 50
const MIN_ALTURA = -5	#Mínima altura de la variaciones en el suelo
const MAX_ALTURA = 5	#Máxima altura de las variaciones en el suelo


var noise = OpenSimplexNoise.new()

func _ready():
	randomize()
	_anhade_suelo_plano($TileMap, 10, MAP_HEIGHT, POS_X_INICIAL, POS_Y_INICIAL)	# planicie para la salida
	_anhade_suelo_con_monticulos($TileMap, MAP_LENGTH - 20, MIN_ALTURA, MAX_ALTURA, POS_X_INICIAL + 10, POS_Y_INICIAL)	# montículos creados con función de ruido
	_anhade_suelo_plano($TileMap, 10, MAP_HEIGHT, MAP_LENGTH - 10, 0)	# planicie para la meta
	_create_hueco($TileMap, MAP_LENGTH, MAP_HEIGHT, MIN_ALTURA, MAX_ALTURA, 0, POS_Y_INICIAL)
	#_create_rampa($TileMap, MAP_LENGTH, 3, 0, -3)
	
# Añade a tilemap un suelo de ancho width y de profundidad height a partir de la posición (pox_x, pos_y)
func _anhade_suelo_con_monticulos(tilemap, length, min_height, max_height, pos_x, pos_y):
	var noise = OpenSimplexNoise.new()
	noise.seed = randi()
	noise.lacunarity = 2.0 # ¿? Valor default 2.0
	noise.octaves = 9	#Fluidez de los cambios cuanto mas alto mas fluido (0 min ,9 max)
	noise.period = 1.0	# frecuencia con la que se produce un cambio de altura
	noise.persistence = 1	# ¿cuánto afectan los cambios anteriores a los futuros (1 max, 0 min)?
	
	var y = 0
	
	var noise_shift = 50
	for x in range(length):
		if randi()%4 == 1:#Crea el suelo
			y = y + noise.get_noise_1d(noise_shift) * float(randi()%FACTOR_ALTO_MONTICULOS)
			noise_shift += 1
		y = max(min_height, y); y = min(max_height, y)
		tilemap.set_cellv(Vector2(pos_x + x, pos_y - y), FLOOR_CELL_ID)
		for g in range (min_height - 1, y): #Rellena el suelo
			tilemap.set_cellv(Vector2(pos_x + x, pos_y - g), FLOOR_CELL_ID)
	tilemap.update_bitmask_region()

func _anhade_suelo_plano(tilemap, length, height, pos_x , pos_y):
	for x in range(length):
		if height < 0:
			for y in range(height+1, 1):
				tilemap.set_cellv(Vector2(pos_x + x, pos_y - y), FLOOR_CELL_ID)
		else:
			for y in range(1, height + 1):
				tilemap.set_cellv(Vector2(pos_x + x, pos_y - y), FLOOR_CELL_ID)
	tilemap.update_bitmask_region()

func _create_hueco(tilemap, width, height, min_height,max_height, pos_x, pos_y):#Crea huecos en el suelo
	var distance_entre_huecos = 0 #Distancia entre los huecos
	var width_huecos = 0 #Ancho de los huecos
	var final_pos_huecos = 0
	var bloques_en_final = 30 #Bloques que hay en la plataforma final
	distance_entre_huecos = randi()%10+20 #Distance huecos coge valores entre 10 y 30
	width_huecos = randi()%12+10 #Width huecos coge valores entre 10 y 22
	while((final_pos_huecos+distance_entre_huecos) < width - bloques_en_final):
		for x in range(final_pos_huecos + distance_entre_huecos, final_pos_huecos + distance_entre_huecos + width_huecos):
			for y in range(min_height - 1, max_height + 1):
					if x == final_pos_huecos + distance_entre_huecos + width_huecos - 1:
							final_pos_huecos = pos_x+x
							#Se reinician los valores
							distance_entre_huecos = randi()%30+20 
							width_huecos = randi()%5+5 
					tilemap.set_cellv(Vector2(pos_x+x, pos_y-y), 1)
	tilemap.update_bitmask_region()
	

func _create_rampa(tilemap,width,height,pos_x,pos_y):#Crea rampas en el suelo
	pass
	#tilemap.update_bitmask_region()
