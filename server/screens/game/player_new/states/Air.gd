extends State


func enter(msg := {}) -> void:
	print("XFCN")
	owner.animatedSprite.play("jump")


func integrate_forces(state):
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

