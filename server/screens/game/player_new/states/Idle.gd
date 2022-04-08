extends State


func enter(_msg := {}) -> void:
	owner.animatedSprite.play("idle")


func integrate_forces(state):
	pass

func update(_delta: float) -> void:
	if owner.input_direction_x != 0.0:
		state_machine.transition_to("Run")
	if !owner.is_on_floor():
		state_machine.transition_to("Air")

