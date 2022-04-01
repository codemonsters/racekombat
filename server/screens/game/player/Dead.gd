extends State


func enter(_msg := {}) -> void:
	owner.velocity = Vector2.ZERO
	owner.global_position = Vector2(-50, -50)
	owner.visible = false


func update(_delta: float) -> void:
	pass

func exit():
	owner.visible = true
