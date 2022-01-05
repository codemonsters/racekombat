extends State


func enter(_msg := {}) -> void:
	owner.velocity = Vector2.ZERO
	owner.animatedSprite.play("idle")


func update(_delta: float) -> void:
	if owner.input_direction_x != 0.0:
		stateMachine.transitionTo("Run")
	if owner.is_on_floor():
		owner.snap = owner.defaultSnap
		owner.velocity = owner.move_and_slide_with_snap(owner.velocity, owner.snap, Vector2.UP)
	else:
		owner.snap = Vector2.ZERO
		stateMachine.transitionTo("Air")
		return
