extends State


func enter(_msg := {}) -> void:
	pass


func integrate_forces(state):
	var initial_force = randi() % 600 + 600 
	owner.apply_central_impulse(Vector2(initial_force, 0))

	state_machine.transition_to("Run")
