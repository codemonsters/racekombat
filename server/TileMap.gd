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
				
#func create_map(cn_x,cn_y,width,height):
#	for cn_x in range(width):
#		for cn_y in range(height):
#			var local_width = 5
#			local_width = randi()%5+0
#			var local_height = 5
#			local_height = randi()%4+1
#			create_noise(cn_x+local_width,cn_y+local_height,local_width,local_height)

func _ready():
#	create_map(-40,0,100,10)
	create_noise(0,0,50,5)
	create_noise(-40,0,20,5)
	self.position.x = (ProjectSettings.get("display/window/size/width"))/2
	self.position.y = (ProjectSettings.get("display/window/size/height"))/2
#noise.get_noise_2d(x+x_pos,y+y_pos)

