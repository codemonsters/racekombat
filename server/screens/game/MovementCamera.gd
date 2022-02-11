extends Camera2D
var speed = 0
var baseSpeed = 150
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func _process(delta):
#	var sum = 0	
#	var multiplier = 1
#	if not speed == 0:
#		for player in get_parent().players:
#			sum += player.values()[0].position.x
#		sum /= get_parent().players.size()
#		multiplier = 1 + ((sum - position.x) / 100)
	
	position.x += speed * delta #* multiplier

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
