extends KinematicBody2D

var velocity = Vector2()
export var gravity = 1000
export var speed_run = 300
export var speed_jump = 600
export var speed_dash = 1200 # TODO: Ajustarlo?
onready var animatedSprite = $AnimatedSprite
export var inicialMult := 1.0
export var floorAcceleration = 20
export var airAcceleration = 10
var defaultSnap = Vector2.DOWN * 15
var snap = defaultSnap
var input_direction_x := 0.0
var input_direction_y := 0.0



func _handle_input(action, is_pressed):
	if is_pressed:
		match action:
			"up":
				input_direction_y += 1.0
			"down":
				input_direction_y -= 1.0
			"left":
				input_direction_x -= 1.0
			"right":
				input_direction_x += 1.0
			"action":
				_jump()
			"dash":
				_dash()
	else:
		match action:
			"left":
				input_direction_x += 1.0
			"right":
				input_direction_x -= 1.0
			"up":
				input_direction_y -= 1.0
			"down":
				input_direction_y += 1.0
	
	input_direction_x = clamp(input_direction_x, -1.0, 1.0)
	input_direction_y = clamp(input_direction_y, -1.0, 1.0)



func _jump():
	if $"Player SM".state.name != "Air":
		SfxManager.PlayerJumpSound()
		$"Player SM".transition_to("Air", {jump = true})

func _dash():
	if $DashCountdown.is_stopped():
		$DashCountdown.start()
		$"Player SM".transition_to("Dash")
