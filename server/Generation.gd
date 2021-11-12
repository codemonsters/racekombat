extends Node2D

var noise = OpenSimplexNoise.new()

func _ready():
	randomize()
	noise.seed = randi()
	noise.octaves = 4
	noise.period = 20.0
	noise.persistence = 0.8
	
	
	for x in range(100):
		for y in range(20):
			var noise_height = noise.get_noise_1d(x)
			
			if ceil(noise_height * 10) < y or y > 8:
				$TileMap.set_cellv(Vector2(x, y), 2)
	
	$TileMap.update_bitmask_region()
