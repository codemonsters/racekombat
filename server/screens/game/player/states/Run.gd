extends State

var frameCounter = 0

func enter(_msg := {}) -> void:
	owner.animatedSprite.play("run")


func physicsUpdate(delta: float) -> void:
	if not owner.is_on_floor():
		owner.snap = Vector2.ZERO
		stateMachine.transitionTo("Air")
		return
	owner.snap = owner.defaultSnap
	
	if owner.input_direction_x < 0:
		owner.animatedSprite.flip_h = true
	elif owner.input_direction_x > 0:
		owner.animatedSprite.flip_h = false

	if owner.velocity.x < owner.speed_run * owner.input_direction_x:
		owner.velocity.x = owner.velocity.x + owner.floorAcceleration
	elif owner.velocity.x > owner.speed_run * owner.input_direction_x:
		owner.velocity.x = owner.velocity.x - owner.floorAcceleration

	owner.velocity.y += owner.gravity * delta
	owner.velocity = owner.move_and_slide_with_snap(owner.velocity, owner.snap, Vector2.UP)
	if is_equal_approx(owner.velocity.x, 0.0):
		stateMachine.transitionTo("Idle")
		frameCounter = 0
	else:
		frameCounter += 1
		if frameCounter == 15:
			SfxManager.PlayerStepSound()
			frameCounter = 0