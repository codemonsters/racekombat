extends State

# var reset_vertical_vel = false

func enter(_msg := {}) -> void:
	# Check what kind of dash we tried: horizontal, vertical or both
	# if owner.input_direction_x != 0 and owner.input_direction_y == 0:
	# 	owner.velocity.x = owner.speed_dash * owner.input_direction_x
	# 	state_machine.transition_to("Run")
	# elif owner.input_direction_x == 0 and owner.input_direction_y != 0:
	# 	owner.velocity.y = - owner.speed_dash
	# 	#owner.animatedSprite.play("jump")
	# 	stateMachine.transition_to("Air")
	# elif owner.input_direction_x == 0 and owner.input_direction_y == 0:
	# 	if owner.facingDirection == 1:
	# 		owner.velocity.x = owner.speed_dash
	# 	else:
	# 		owner.velocity.x = - owner.speed_dash
		
	# 	stateMachine.transition_to("Run")
	# else:
	# 	owner.velocity.x = owner.speed_dash * owner.input_direction_x
	# 	owner.velocity.y = owner.speed_dash * - owner.input_direction_y
	# 	state_machine.transition_to("Air")
		

	# NOTA: En el gamepad del móvil no existe input "diagonal", por lo tanto no se debería implementar el dash en diagonal.
	# TODO: Deliberar la mejor manera de hacerlo.

	if owner.input_direction_x != 0 and owner.input_direction_y == 0:
		owner.apply_central_impulse(Vector2(owner.force_dash * owner.input_direction_x, 0))
	elif owner.input_direction_x == 0 and owner.input_direction_y > 0:
		owner.upwards_dash = true #Flag that triggers upwards dash in Player.gd
	elif owner.input_direction_x == 0 and owner.input_direction_y < 0:
		owner.downwards_dash = true #Flag that triggers downwards dash in Player.gd
	elif owner.input_direction_x == 0 and owner.input_direction_y == 0:
		if owner.facingDirection == 1:
			owner.apply_central_impulse(Vector2(owner.force_dash, 0))
		else:
			owner.apply_central_impulse(Vector2(-owner.force_dash, 0))

	state_machine.transition_to("Run")
		

	$SmokeParticles.position = owner.get_global_position()
	$SmokeParticles.emitting = true
	SfxManager.PlayerDashSound()

func _integrate_forces(state):
	# if reset_vertical_vel == true:
	# 	state.linear_velocity.y = 0
	# 	reset_vertical_vel = false
	pass
