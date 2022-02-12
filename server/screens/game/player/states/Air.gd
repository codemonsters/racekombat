extends State

var velocidadInicial

func enter(msg := {}) -> void:
	if msg.has("jump"):
		owner.velocity.y = - owner.speed_jump
		owner.animatedSprite.play("jump")
	else:
		owner.animatedSprite.play("fall")
	if msg.has("velocidadInicial"):
		velocidadInicial = msg.velocidadInicial * owner.inicialMult
	else:
		velocidadInicial = 0

func physicsUpdate(delta: float) -> void:
	if owner.velocity.y > 0:
		owner.animatedSprite.play("fall")
	if owner.input_direction_x < 0:
		owner.animatedSprite.flip_h = true
	elif owner.input_direction_x > 0:
		owner.animatedSprite.flip_h = false

	if owner.velocity.x < owner.speed_run * owner.input_direction_x:
		owner.velocity.x = owner.velocity.x + owner.airAcceleration
	elif owner.velocity.x > owner.speed_run * owner.input_direction_x:
		owner.velocity.x = owner.velocity.x - owner.airAcceleration

	owner.velocity.y += owner.gravity * delta
	owner.velocity = owner.move_and_slide(owner.velocity, Vector2.UP)
	
	if owner.is_on_floor():
		if is_equal_approx(owner.velocity.x, 0.0):
			stateMachine.transitionTo("Idle")
		else:
			if int(abs(owner.velocity.x)) % owner.floorAcceleration == owner.airAcceleration:
				owner.velocity.x -= owner.airAcceleration
			stateMachine.transitionTo("Run")
