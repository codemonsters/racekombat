extends State


func enter(_msg := {}) -> void:
	owner.velocity.x = owner.speed_dash * owner.input_direction_x
	owner.animatedSprite.play("idle")


func update(_delta: float) -> void:
	# TODO: Hay que añadir soporte para dash vertical, y mejorar quizás el horizontal
#	if owner.input_direction_x != 0.0:
	stateMachine.transitionTo("Run")
#	if owner.is_on_floor():
#		owner.snap = owner.defaultSnap
#		owner.velocity = owner.move_and_slide_with_snap(owner.velocity, owner.snap, Vector2.UP)
#	else:
#		owner.snap = Vector2.ZERO
#		stateMachine.transitionTo("Air")
#		return
