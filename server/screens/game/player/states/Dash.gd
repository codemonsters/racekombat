extends State


func enter(_msg := {}) -> void:
	# Check what kind of dash we tried: horizontal, vertical or both
	if owner.input_direction_x != 0 and owner.input_direction_y == 0:
		owner.velocity.x = owner.speed_dash * owner.input_direction_x
		stateMachine.transitionTo("Run")
	elif owner.input_direction_x == 0 and owner.input_direction_y != 0:
		owner.velocity.y = - owner.speed_dash
		#owner.animatedSprite.play("jump")
		stateMachine.transitionTo("Air")
	else:
#		owner.velocity.x = owner.speed_dash * owner.input_direction_x
		owner.velocity.y = owner.speed_dash * - owner.input_direction_y
		stateMachine.transitionTo("Air")
		
	# owner.animatedSprite.play("idle")


func update(_delta: float) -> void:
	pass

