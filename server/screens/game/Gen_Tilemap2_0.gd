extends Worlds


#Sobre el tilemap: El origen de coordenadas (0,0) coincide con la posicion de salida de los jugadores
#Todas las distancias y posiciones se expresan en tiles un tile mide 16x16
#El suelo se genera con una funcion de ruido y su pos_y fluctua entre MIN_ALTURA y MAX_ALTURA 
#En el eje x todo el escenario esta comprendido entre 0 y MAP_LENGTH

var FACTOR_ALTO_MONTICULOS = 25
var POS_X_INICIAL = 0
var POS_Y_INICIAL = 0 #Y esta invertida - es una pos_y mas alta y + una mas baja

var noise = OpenSimplexNoise.new()

signal tilemap_generated

func _ready():
	MAP_LENGTH = 500	# longitud del mapa (en tiles)
	MAP_HEIGHT = -20 # altura del mapa (en tiles) un valor negativo hace que el mapa se genere hacia abajo y uno positivo que se genere hacia arriba tiene que tener un valor |min_altura| + 2 "valor absoluto"
	FLOOR_CELL_ID = 4	# id del tipo de loseta que se usará para el suelo
	VACUM_CELL_ID = 1	# id del tipo de loseta que se usará para el vacío
	MIN_ALTURA = -4	#Mínima altura de la iaciones en el suelo
	MAX_ALTURA = 4	#Máxima altura de las iaciones en el suelo
	_create_tilemap()

func _create_tilemap():
	_clear_tilemap()
	randomize()
	_anhade_suelo_plano($TileMap, 10, MAP_HEIGHT, POS_X_INICIAL, POS_Y_INICIAL)	# planicie para la salida
	_anhade_suelo_con_monticulos($TileMap, MAP_LENGTH - 20, MAP_HEIGHT, MIN_ALTURA, MAX_ALTURA, POS_X_INICIAL + 10, POS_Y_INICIAL)	# montículos creados con función de ruido
	_anhade_suelo_plano($TileMap, 10, MAP_HEIGHT, MAP_LENGTH - 10, 0)	# planicie para la meta
	_create_hueco($TileMap, MAP_LENGTH, MAP_HEIGHT, MIN_ALTURA, MAX_ALTURA, 0, POS_Y_INICIAL)
	_create_plataforma($TileMap, MAP_LENGTH, MAP_HEIGHT, MIN_ALTURA, MAX_ALTURA, 0, POS_Y_INICIAL)
	emit_signal("tilemap_generated")



# Añade a tilemap un suelo de ancho width y de profundidad height a partir de la posición (pox_x, pos_y)
func _anhade_suelo_con_monticulos(tilemap, length, height, min_height, max_height, pos_x, pos_y):
	var noise = OpenSimplexNoise.new()
	noise.seed = randi()
	noise.lacunarity = 2.0 # ¿? Valor default 2.0
	noise.octaves = 9.0	#Fluidez de los cambios cuanto mas alto mas fluido (0 min ,9 max)
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
		for g in range (height + 1, y): #Rellena el suelo
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

func _create_hueco(tilemap, lenght, height, min_height,max_height, pos_x, pos_y):#Crea huecos en el suelo
	var distance_entre_huecos = 0 #Distancia entre los huecos
	var width_huecos = 0 #Ancho de los huecos
	var final_pos_huecos = 0
	var bloques_en_final = 30 #Bloques que hay en la plataforma final
	distance_entre_huecos = randi()%(lenght/10) + 10 #Distance huecos coge valores entre 10 y 30
	width_huecos = randi()%6 + 8 #Width huecos coge valores entre 10 y 22
	while((final_pos_huecos+distance_entre_huecos) < lenght - bloques_en_final):
		for x in range(final_pos_huecos + distance_entre_huecos, final_pos_huecos + distance_entre_huecos + width_huecos):
			for y in range(height + 1, max_height + 1):
					if x == final_pos_huecos + distance_entre_huecos + width_huecos - 1:
							final_pos_huecos = pos_x + x
							#Se reinician los valores
							distance_entre_huecos = randi()%(lenght/10) + 10
							width_huecos = randi()%6 + 8
					tilemap.set_cellv(Vector2(pos_x+x, pos_y-y), VACUM_CELL_ID)
	tilemap.update_bitmask_region()
	
func _create_plataforma(tilemap, lenght, height, min_height,max_height, pos_x, pos_y):#Crea plataforma en el aire
	var distance_entre_plataforma = 20 #Distancia entre los plataforma
	var width_plataforma = 7 #Ancho de los plataforma
	var final_pos_plataforma = 20 #Pos_x del bloque final de cada plataforma
	var distance = 0
	var y_max_floor := []
	var y_max := []
	var platform_avaliable = false
	var altura_plataformas = 0 #Altura en la que se construye la plataforma contando desde la altura del tile mas alto
	var grosor_plataformas = 2
	var altura_anadida_hueco = 10 #Altura en la que se construye la plataforma cuando hay un hueco
	while((final_pos_plataforma + distance_entre_plataforma) < lenght ):
		distance = final_pos_plataforma + distance_entre_plataforma
		altura_plataformas = 5 #Seteamos la altura dentro del while 
		altura_plataformas = altura_plataformas + randi()%6
		for x in range(distance, distance + width_plataforma):
			for y in range(min_height, max_height + 1):
				if tilemap.get_cellv(Vector2(pos_x + x, pos_y - y)) == FLOOR_CELL_ID:
					y_max_floor.append(y)
				else:
					y_max_floor.append(0)
				y_max.append(y_max_floor.max())
				y_max_floor.clear()
		if y_max.max() == y_max.min():
			altura_anadida_hueco = 1
			platform_avaliable = true
		elif y_max.max() - y_max.min() < 5:
			altura_anadida_hueco = 0
			platform_avaliable = true
		else:
			platform_avaliable = false
			final_pos_plataforma += 20
		if platform_avaliable == true:
			for x in range(distance, distance + width_plataforma):
				for y in range( y_max.max() + altura_plataformas + altura_anadida_hueco, y_max.max() + altura_plataformas + grosor_plataformas + altura_anadida_hueco):
					tilemap.set_cellv(Vector2(pos_x + x, pos_y - y), FLOOR_CELL_ID)
					final_pos_plataforma = pos_x + x
		y_max.clear()
	tilemap.update_bitmask_region()


func _clear_tilemap():
	for pos in $TileMap.get_used_cells_by_id(FLOOR_CELL_ID):
		$TileMap.set_cellv(pos, VACUM_CELL_ID)
