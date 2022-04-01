extends State


func enter(_msg := {}) -> void:
	# Check what kind of dash we tried: horizontal, vertical or both
	if owner.input_direction_x != 0 and owner.input_direction_y == 0:
		owner.velocity.x = owner.speed_dash * owner.input_direction_x
		state_machine.transition_to("Run")
	elif owner.input_direction_x == 0 and owner.input_direction_y != 0:
		owner.velocity.y = - owner.speed_dash
		#owner.animatedSprite.play("jump")
		state_machine.transition_to("Air")
	else:
#		owner.velocity.x = owner.speed_dash * owner.input_direction_x
		owner.velocity.y = owner.speed_dash * - owner.input_direction_y
		state_machine.transition_to("Air")
		
	# owner.animatedSprite.play("idle")


func update(_delta: float) -> void:
	pass

