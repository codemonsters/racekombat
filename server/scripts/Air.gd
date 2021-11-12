extends State

func enter(msg := {}) -> void:
	if msg.has("jump"):
		owner.velocity.y = owner.velocidadSalto
		owner.animatedSprite.play("jump")
	else:
		owner.animatedSprite.play("fall")

func physicsUpdate(delta: float) -> void:
	if owner.velocity.y > 0:
		owner.animatedSprite.play("fall")
	var inputDirectionX: float = (
		Input.get_action_strength("ui_right")
		- Input.get_action_strength("ui_left")
	)
	owner.velocity.x = owner.velocidad * inputDirectionX
	owner.velocity.y += owner.gravedad * delta
	owner.velocity = owner.move_and_slide(owner.velocity, Vector2.UP)
	
	if owner.is_on_floor():
		if is_equal_approx(owner.velocity.x, 0.0):
			stateMachine.transitionTo("Idle")
		else:
			stateMachine.transitionTo("Run")
