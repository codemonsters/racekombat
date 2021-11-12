extends TileMap
	
#func create_noise(x_pos, y_pos, width, height):
	#for x in range(width):
		#for y in range(height):
			#if y+y_pos < noise.get_noise_2d(x + x_pos + 123456, 0) * 50:
				#continue
			
			#set_cell(x + x_pos, y + y_pos, noise.get_noise_2d(x + x_pos, y + y_pos) * 2 + 2)

#func _ready():
	#randomize()
	#noise.octaves = rand_range(1.0, 10.0)
	#noise.period = 250
	#noise.seed = randi()
	
	#create_noise(-50, -10, 2000, 200)
	#update_bitmask_region()

#func _process(delta):
	#$Camera2D.position += Vector2(500.0, 0.0) * delta
