extends RigidBody2D

var velocity = Vector2()
# export var gravity = 1000
export var speed_run = 300
export var force_run = 1500
export var speed_jump = 600
# export var force_jump = 600
# export var speed_dash = 1200
export var force_dash = 500
onready var animatedSprite = $AnimatedSprite
export var inicialMult := 1.0
# export var floorAcceleration = 20
# export var airAcceleration = 10
var defaultSnap = Vector2.DOWN * 15
var snap = defaultSnap
var input_direction_x := 0.0
var input_direction_y := 0.0
var facingDirection = 1 # 0 = Izquierda | 1 = Derecha
var on_floor = false
var collision_number = 0


func _ready():
	_start_dash_tween()
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
		# $"Player SM/Dash/SmokeParticles".position = self.position
		# $"Player SM/Dash/SmokeParticles".emitting = true
		_start_dash_tween()
#		$"Dash Bar".color = Color("ab9f9f")
		$"Dash Bar".visible = true
		$"Player SM".transition_to("Dash")


func is_on_floor():
	return on_floor


func _integrate_forces(state):
	if input_direction_x < 0.0 && linear_velocity.x > -speed_run:
		applied_force = Vector2(-force_run, 0)
	elif input_direction_x > 0.0 && linear_velocity.x < speed_run:
		applied_force = Vector2(force_run, 0)
	else:
		applied_force = Vector2(0, 0)
	$"Player SM".integrate_forces(state)

	# For debugging collisions
	# if collision_number < 0:
	# 	print(self.name + ":" + str(collision_number))

func _on_FeetSensor_body_entered(body):
	if "PlayerNew" in body.name:
		return
	on_floor = true
	collision_number += 1
	# print(body.name + " entered "  + self.name)


func _on_FeetSensor_body_exited(body):
	if "PlayerNew" in body.name:
		return
	collision_number -= 1
	# print(body.name + " exited "  + self.name)
	if collision_number == 0:
		on_floor = false

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
