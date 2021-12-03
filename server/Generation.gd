extends Node2D

var noise = OpenSimplexNoise.new()

func _ready():
	randomize()
	var length = 10
	var width = 50
	var distance = 0
	var total_distance = 0
	
	for x in range(length):
		total_distance += distance
		_create_noise(width, 30, x * width + total_distance, 10)
		var tile = $TileMap.world_to_map(Vector2(width * x + total_distance, 30))
		distance = randi()%10+1
		print(tile)
		#if rand_range(1, 10) > 8:
			#distance = 20
	_create_noise_roof(width * length + total_distance, 20, 0, -3)




func _create_noise(width,height,pos_x,pos_y):
	noise.seed = randi()
	noise.octaves = 20
	noise.period = 15.0 #rand_range(15.0, 30.0)
	noise.persistence = 0.8

	
	for x in range(width):
		for y in range(height):
			var noise_height = noise.get_noise_1d(x)
			
			if ceil(noise_height * 40) < y :
				$TileMap.set_cellv(Vector2(pos_x+x, pos_y+y), 2)
				
	$TileMap.update_bitmask_region()

func _create_noise_roof(width, height, pos_x, pos_y):
	noise.seed = randi()
	noise.octaves = 8
	noise.period = 10
	noise.persistence = 0.5
	for x in range(width):
		for y in range(height):
			var noise_height = noise.get_noise_1d(x)
			
			if ceil(noise_height * 40) < y :
				$RoofTileMap.set_cellv(Vector2(pos_x+x, pos_y+y), 0)
	
	$RoofTileMap.scale.y = -1
	$RoofTileMap.update_bitmask_region()
