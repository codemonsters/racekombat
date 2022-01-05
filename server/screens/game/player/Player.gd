extends KinematicBody2D

var velocity = Vector2()
var velocidad = 300
var gravedad = 1000
var velocidadSalto = -600
onready var animatedSprite = $AnimatedSprite
export var inicialMult := 1.0
export var airMult := 1.0
var defaultSnap = Vector2.DOWN * 15
var snap = defaultSnap
var input_direction_x := 0.0

func _ready():
	pass

func _process(delta):
	pass
	#print(get_node("Player SM").state.name)

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
