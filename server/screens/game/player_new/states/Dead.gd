extends State


func enter(_msg := {}) -> void:
	owner.set_linear_velocity(Vector2.ZERO)
	owner.global_position = Vector2(-50, -50)
	owner.visible = false


func update(_delta: float) -> void:
	pass

func integrate_forces(state):
	pass
	

func exit():
	owner.visible = true
