extends State

func enter(_msg := {}) -> void:
	owner.velocity = Vector2.ZERO

func handleInput(event):
	if Input.is_action_just_pressed("ui_accept") and owner.is_on_floor():
		stateMachine.transitionTo("Air", {jump = true})
	elif Input.is_action_just_pressed("ui_cancel"):
		owner.velocity = Vector2.ZERO
		owner.position = Vector2(0, 0)
	# XOR, para evitar que al mantener ambas teclas cambie rapidamente entre Idle y Run
	elif (Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right")) or (Input.is_action_pressed("ui_right") and not Input.is_action_pressed("ui_left")):
		stateMachine.transitionTo("Run")
	
	

func update(delta: float) -> void:
	if not owner.is_on_floor():
		stateMachine.transitionTo("Air")
		return
