extends State


func enter(_msg := {}) -> void:
	print("U")
	owner.set_linear_velocity(Vector2.ZERO)
	owner.animatedSprite.play("idle")


func _integrate_forces(state) -> void:
	if owner.linear_velocity.x != 0.0:
		stateMachine.transitionTo("Run")
	print(stateMachine.state)
	if owner.is_on_floor():
		owner.snap = owner.defaultSnap
	else:
		owner.snap = Vector2.ZERO
		stateMachine.transitionTo("Air")
		return

func physicsUpdate(delta):
	owner.set_applied_force(owner.velocity)
