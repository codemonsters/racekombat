extends Node2D

var noise = OpenSimplexNoise.new()

func _ready():
	randomize()
	
	_create_suelo(1000,5,-50,0)
	_create_hueco(1000,5,-50,0)
	#_create_rampa(100,5,0,10)
	
func _create_suelo(width,height,pos_x,pos_y):
	
	noise.octaves = 0
	noise.period = 100000
	noise.lacunarity= 1000
	
	for x in range(width):
		for y in range(height):
			var noise_height = noise.get_noise_1d(x)
			
			if ceil(noise_height * 10) < y:
				$TileMap.set_cellv(Vector2(pos_x+x, pos_y+y), 2)
				
	$TileMap.update_bitmask_region()
	
func _create_hueco(width,height,pos_x,pos_y):
	var distance_entre_huecos = 0
	var width_huecos = 0
	distance_entre_huecos = randi()%10+10
	width_huecos = randi()%5+5
	for x in range(width):
		for y in range(height):
			if (pos_x+x) == 0:
				pass
			elif (pos_x+x)%distance_entre_huecos == 0:
				#for z in range(width_huecos):
				$TileMap.set_cellv(Vector2(pos_x+x, pos_y+y), 1)
	
	
func _create_rampa(width,height,pos_x,pos_y):
	for x in range(width):
		for y in range(height):
			$TileMap.set_cellv(Vector2(pos_x+x, pos_y+y), 2)
	
	$TileMap.update_bitmask_region()

