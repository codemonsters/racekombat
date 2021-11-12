extends Node


var containers = { 
	1: "ArrowLeft",
	2: "ArrowRight",
	3: "ButtonA",
	4: "ButtonB",
	
}


func _on_container_gui_input(event, container_number):

	if (event is InputEventMouseButton or event is InputEventScreenTouch) \
			and event.pressed:
		print(containers[container_number])
