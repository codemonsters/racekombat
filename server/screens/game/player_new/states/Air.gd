extends State


func enter(msg := {}) -> void:
	if msg.has("jump"):
		owner.animatedSprite.play("jump") #TODO: ESTO NO FURULA
	# else:
	# 	owner.animatedSprite.play("fall")

func integrate_forces(state):
	# ESTO VA RARO
	# if jump == true:
	# 	state.apply_central_impulse(Vector2(0, -owner.force_jump))
	# 	jump = false

	if state.linear_velocity.y > 0:
		owner.animatedSprite.play("fall")
	if owner.input_direction_x < 0:
		owner.animatedSprite.flip_h = true
	elif owner.input_direction_x > 0:
		owner.animatedSprite.flip_h = false

	if owner.is_on_floor():
		if is_equal_approx(state.linear_velocity.x, 0.0):
			state_machine.transition_to("Idle")
		elif abs(state.linear_velocity.x) > 0.0:
			state_machine.transition_to("Run")
