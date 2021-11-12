extends State

func handleInput(event):
	if Input.is_action_just_pressed("ui_accept"):
		stateMachine.transitionTo("Air", {jump = true})

func physicsUpdate(delta: float) -> void:
	if not owner.is_on_floor():
		stateMachine.transitionTo("Air")
		return
	var inputDirectionX: float = (
		Input.get_action_strength("ui_right")
		- Input.get_action_strength("ui_left")
	)
	owner.velocity.x = owner.velocidad * inputDirectionX
	owner.velocity.y += owner.gravedad * delta
	owner.velocity = owner.move_and_slide(owner.velocity, Vector2.UP)
	if is_equal_approx(inputDirectionX, 0.0):
		stateMachine.transitionTo("Idle")
