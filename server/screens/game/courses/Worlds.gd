class_name Worlds extends Node2D


export var MAP_LENGTH: int # Ancho del mundo
export var MAP_HEIGHT: int
export var MAX_ALTURA: int
export var MIN_ALTURA: int
export var FLOOR_CELL_ID: int
export var VACUM_CELL_ID: int


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func calcular_y_media():
	var resultados := []
	for x in range(MAP_LENGTH):
		var coordenadasy_suelos := []
		var dentro_de_solido := false
		# Loopea por todo el mapa de columna en columna y coge la altura del tile más alto.
		for y in range(-MAX_ALTURA, -MIN_ALTURA + 1):
			var cell_id = $TileMap.get_cell(x, y)
			if cell_id == FLOOR_CELL_ID and not dentro_de_solido:
				dentro_de_solido = true
				coordenadasy_suelos.append(y)
			elif cell_id == VACUM_CELL_ID:
				dentro_de_solido = false
		if coordenadasy_suelos.size() == 0:
			resultados.append(null)
		else: # Calcular media
			var sum = 0
			for coordenaday in coordenadasy_suelos:
				sum += coordenaday
			resultados.append(sum / coordenadasy_suelos.size())
	return resultados
