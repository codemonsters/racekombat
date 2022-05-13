extends State


func enter(_msg := {}) -> void:
	owner.global_position = Vector2(-50, -50)
	owner.visible = false


func update(_delta: float) -> void:
	pass

func integrate_forces(state):
	pass
	

func exit():
	owner.set_mode(RigidBody2D.MODE_STATIC)
	owner.set_mode(RigidBody2D.MODE_CHARACTER)
	owner.visible = true
