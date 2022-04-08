extends State

var frameCounter = 0

func enter(_msg := {}) -> void:
	owner.animatedSprite.play("run")

func integrate_forces(state):
	if not owner.is_on_floor():
		owner.snap = Vector2.ZERO
		state_machine.transition_to("Air")
		return
	owner.snap = owner.defaultSnap
	
	if owner.input_direction_x < 0:
		owner.animatedSprite.flip_h = true
	elif owner.input_direction_x > 0:
		owner.animatedSprite.flip_h = false
		
	if is_equal_approx(state.linear_velocity.x, 0.0):
		state_machine.transition_to("Idle")
		frameCounter = 0
	else:
		frameCounter += 1
		if frameCounter == 15:
			SfxManager.PlayerStepSound()
			frameCounter = 0
