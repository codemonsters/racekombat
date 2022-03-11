extends Sprite

var turning_right = true
var rotation_accel = 0

func _process(delta):
	if position.x == 640:
		rotation_degrees += rotation_accel
		if turning_right:
			rotation_accel += 0.05
		else:
			rotation_accel -= 0.05
			
		if rotation_degrees > 1:
			turning_right = false
		elif rotation_degrees < -1:
			turning_right = true
			
		if rotation_accel > 1:
			rotation_accel = 1
		elif rotation_accel < -1:
			rotation_accel = -1
		
