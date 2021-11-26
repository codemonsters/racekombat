extends Node2D

var noise = OpenSimplexNoise.new()

func _ready():
	randomize()
#_create_noise(50,30,0,10)
#_create_noise(50,30,50*1+10,10)
	var distance = 0
	for x in range(10):
		var width = 50
		_create_noise(width,30,x*width+distance,10)
		distance = randi()%10+1
	
func _create_noise(width,height,pos_x,pos_y):
	noise.seed = randi()
	noise.octaves = 4
	noise.period = rand_range(10.0,20.0)
	print(noise.period)
	noise.persistence = 0.8
	for x in range(width):
		for y in range(height):
			var noise_height = noise.get_noise_1d(x)
			
			if ceil(noise_height * 40) < y :
				$TileMap.set_cellv(Vector2(pos_x+x, pos_y+y), 2)
				

	
	$TileMap.update_bitmask_region()
