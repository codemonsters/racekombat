extends KinematicBody2D

var velocity = Vector2()
export var gravity = 1000
export var speed_run = 300
export var speed_jump = 600
onready var animatedSprite = $AnimatedSprite
export var inicialMult := 1.0
export var airMult := 0.5
var defaultSnap = Vector2.DOWN * 15
var snap = defaultSnap
var input_direction_x := 0.0


func _handle_input(action, is_pressed):
	if is_pressed:
		match action:
			"left":
				input_direction_x -= 1.0
			"right":
				input_direction_x += 1.0
			"action":
				_jump()
	else:
		match action:
			#TODO: El Gamepad envía esto 3 veces, por lo que hay que hacer algo para que no se vaya al lado contrario
			"left":
				print("vinicio: ", input_direction_x)
				input_direction_x += 1.0
				print("vinterm: ", input_direction_x)
			"right":
				input_direction_x -= 1.0
	
	input_direction_x = clamp(input_direction_x, -1.0, 1.0)
	print("vfinal: ", input_direction_x)



func _jump():
	if $"Player SM".state.name != "Air":
		$"Player SM".transitionTo("Air", {jump = true})
