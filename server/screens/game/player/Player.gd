extends KinematicBody2D

var velocity = Vector2()
export var gravity = 1000
export var speed_run = 300
export var speed_jump = 600
export var speed_dash = 800 # TODO: Ajustarlo?
onready var animatedSprite = $AnimatedSprite
export var inicialMult := 1.0
export var floorAcceleration = 20
export var airAcceleration = 10
var facingDirection = 1 # 0 = Izquierda | 1 = Derecha
var defaultSnap = Vector2.DOWN * 15
var snap = defaultSnap
var input_direction_x := 0.0
var input_direction_y := 0.0


func _ready():
	_start_dash_tween()


func _handle_input(action, is_pressed):
	if is_pressed:
		match action:
			"up":
				input_direction_y += 1.0
			"down":
				input_direction_y -= 1.0
			"left":
				input_direction_x -= 1.0
				facingDirection = 0
			"right":
				input_direction_x += 1.0
				facingDirection = 1
			"action":
				_jump()
			"dash":
				_dash()
	else:
		match action:
			"left":
				input_direction_x += 1.0
				facingDirection = 0
			"right":
				input_direction_x -= 1.0
				facingDirection = 1
			"up":
				input_direction_y -= 1.0
			"down":
				input_direction_y += 1.0
	
	input_direction_x = clamp(input_direction_x, -1.0, 1.0)
	input_direction_y = clamp(input_direction_y, -1.0, 1.0)
	print(input_direction_y)


func _jump():
	if $"Player SM".state.name != "Air":
		SfxManager.PlayerJumpSound()
		$"Player SM".transitionTo("Air", {jump = true})

func _dash():
	if $DashCountdown.is_stopped():
		$DashCountdown.start()
		_start_dash_tween()
#		$"Dash Bar".color = Color("ab9f9f")
		$"Dash Bar".visible = true
		$"Player SM".transitionTo("Dash")


func _start_dash_tween():
	$"Dash Tween".interpolate_property($"Dash Bar", "rect_size:x",
		0, 48, $DashCountdown.wait_time,
		Tween.TRANS_LINEAR, Tween.EASE_IN
	)
	$"Dash Tween".start()


func _on_Dash_Tween_tween_completed(_object, _key):
	$"Dash Bar".color = Color("ffffff")
	$"Dash Bar".visible = false
	SfxManager.PlayerDashBarSound()
