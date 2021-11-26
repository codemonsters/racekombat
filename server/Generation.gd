extends Node2D

var noise = OpenSimplexNoise.new()

func _ready():
	randomize()
	var distance = 0 #Distancia entre chunks
	var width = 50 #Tamaño de chunks en x
	var height = 30 #Tamaño de chunks en x
	for x in range(10):
		var total_distance =+ distance
		_create_noise(width,height,x*(width+total_distance),10)
		distance = randi()%10+5
		
	
func _create_noise(width,height,pos_x,pos_y):
	noise.seed = randi()
	noise.octaves = 15
	noise.period =  15
	noise.persistence = 0.8
	for x in range(width):
		for y in range(height):
			var noise_height = noise.get_noise_1d(x)
			
			if ceil(noise_height * 25) < y :
				$TileMap.set_cellv(Vector2(pos_x+x, pos_y+y), 2)
				

	$TileMap.update_bitmask_region()
