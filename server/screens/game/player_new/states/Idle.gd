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
