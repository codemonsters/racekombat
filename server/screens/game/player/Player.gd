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
			"left":
				input_direction_x += 1.0
			"right":
				input_direction_x -= 1.0
	
	input_direction_x = clamp(input_direction_x, -1.0, 1.0)


func _jump():
	if $"Player SM".state.name != "Air":
		$"Player SM".transitionTo("Air", {jump = true})
