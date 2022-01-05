extends State

func enter(_msg := {}) -> void:
	owner.animatedSprite.play("run")


func physicsUpdate(delta: float) -> void:
	if not owner.is_on_floor():
		owner.snap = Vector2.ZERO
		stateMachine.transitionTo("Air")
		return
	owner.snap = owner.defaultSnap
	#var inputDirectionX: float = (
	#	Input.get_action_strength("ui_right")
	#	- Input.get_action_strength("ui_left")
	#)
	# En el caso de ser inputDirectionX == 0, no se gira el sprite para
	# que el jugador no se gire hacia la derecha al soltar la tecla.
	if owner.input_direction_x < 0:
		owner.animatedSprite.flip_h = true
	elif owner.input_direction_x > 0:
		owner.animatedSprite.flip_h = false
	owner.velocity.x = owner.speed_run * owner.input_direction_x
	owner.velocity.y += owner.gravity * delta
	owner.velocity = owner.move_and_slide_with_snap(owner.velocity, owner.snap, Vector2.UP)
	if is_equal_approx(owner.input_direction_x, 0.0):
		stateMachine.transitionTo("Idle")
