extends RigidBody2D

var velocity = Vector2()
# export var gravity = 1000
export var speed_run = 300
export var force_run = 1000
export var speed_jump = 600
export var force_jump = 600
export var speed_dash = 1200 # TODO: Ajustarlo?
onready var animatedSprite = $AnimatedSprite
export var inicialMult := 1.0
export var floorAcceleration = 20
export var airAcceleration = 10
var defaultSnap = Vector2.DOWN * 15
var snap = defaultSnap
var input_direction_x := 0.0
var input_direction_y := 0.0
var on_floor = false
var collision_number = 0


func _ready():
	pass
	# TODO: deberíamos asignar el número de colisiones reportadas (contacts reported) a el número de personajes + 1

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


# func _physics_process(delta):
# 	if input_direction_x < 0.0:
# 		self.add_central_force(Vector2(-speed_run, 0))	
# 		# print(test_motion(Vector2(-speed_run, 0)))
# 	elif input_direction_x == 0.0:
# 		# self.set_inertia(2000)
# 		print(self.get_linear_velocity())
# 		# print(test_motion(Vector2(-speed_run, 0)))
# 		pass
# 	elif input_direction_x > 0.0:
# 		self.add_central_force(Vector2(speed_run, 0))
# 		# print(test_motion(Vector2(speed_run, 0)))



func _jump():
	# TODO: CHAPUZA
	if on_floor:
		self.set_axis_velocity(Vector2(0, -speed_jump))

	if $"Player SM".state.name != "Air":
		SfxManager.PlayerJumpSound()
		$"Player SM".transition_to("Air", {jump = true})

func _dash():
	if $DashCountdown.is_stopped():
		$DashCountdown.start()
		$"Player SM".transition_to("Dash")


func is_on_floor():
	return on_floor


func _integrate_forces(state):
	if input_direction_x < 0.0 && abs(linear_velocity.x) < speed_run:
		friction = 0
		applied_force = Vector2(-force_run, 0)
	# elif input_direction_x == 0.0:
	# 	applied_force = Vector2(0, 0)
	elif input_direction_x > 0.0 && abs(linear_velocity.x) < speed_run:
		friction = 0
		applied_force = Vector2(force_run, 0)
	else:
		applied_force = Vector2(0, 0)
		friction = 0.4
	$"Player SM".integrate_forces(state)



func _on_FeetSensor_body_entered(body):
	if body == self:
		return
	on_floor = true
	collision_number += 1


func _on_FeetSensor_body_exited(body):
	collision_number -= 1
	if collision_number == 0:
		on_floor = false
