extends State

var velocidadInicial

func enter(msg := {}) -> void:
	if msg.has("jump"):
		owner.velocity.y = owner.velocidadSalto
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
	#var inputDirectionX: float = (
	#	Input.get_action_strength("ui_right")
	#	- Input.get_action_strength("ui_left")
	#)
	if owner.input_direction_x * velocidadInicial < 0:
		owner.velocity.x = velocidadInicial + (owner.velocidad * owner.input_direction_x * owner.airMult)
	elif owner.input_direction_x * velocidadInicial == 0:
		owner.velocity.x = owner.velocidad * owner.input_direction_x
	else:
		owner.velocity.x = velocidadInicial
	owner.velocity.y += owner.gravedad * delta
	owner.velocity = owner.move_and_slide(owner.velocity, Vector2.UP)
	
	if owner.is_on_floor():
		if is_equal_approx(owner.velocity.x, 0.0):
			stateMachine.transitionTo("Idle")
		else:
			stateMachine.transitionTo("Run")
