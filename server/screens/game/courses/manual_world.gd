extends Worlds


# var MAP_LENGTH
# var MAP_HEIGHT
# var MAX_ALTURA
# var MIN_ALTURA
# var FLOOR_CELL_ID
# var VACUM_CELL_ID


# Called when the node enters the scene tree for the first time.
func _ready():
	var map_rect = get_node("TileMap").get_used_rect()
	FLOOR_CELL_ID = 4
	VACUM_CELL_ID = 1
	print("Mapa:", map_rect.size)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _create_tilemap():
	pass
