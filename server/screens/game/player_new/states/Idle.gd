extends State


func enter(_msg := {}) -> void:
	owner.animatedSprite.play("idle")


func integrate_forces(state):
	if state.linear_velocity.x != 0:
		state_machine.transition_to("run")
		print("transition to run")
	elif state.linear_velocity.y != 0:
		state_machine.transition_to("jump")
		print("transition to jump")

	#ESTO NO FUNCIONA
	# if owner.input_direction_x < 0.0 && abs(state.linear_velocity.x) < owner.speed_run:
	# 	state.friction = 0
	# 	state.applied_force = Vector2(-owner.force_run, 0)
	# elif owner.input_direction_x > 0.0 && abs(state.linear_velocity.x) < owner.speed_run:
	# 	state.friction = 0
	# 	state.applied_force = Vector2(owner.force_run, 0)
	# else:
	# 	state.applied_force = Vector2(0, 0)
	# 	state.friction = 0.4
	
