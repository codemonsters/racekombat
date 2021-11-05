extends TileMap

var noise := OpenSimplexNoise.new()
var tile = 0

func _process(delta):
	print(tile)

func create_noise(x_pos,y_pos,width,height):
	for x in range(width):
		for y in range (height):
			if y <= 0 :
				set_cell(01*x+x_pos,01*y+y_pos,randi()%2+0)
			else:
				set_cell(01*x+x_pos,01*y+y_pos,2)

func _ready():
	create_noise(0,0,20,5)
#noise.get_noise_2d(x+x_pos,y+y_pos)

