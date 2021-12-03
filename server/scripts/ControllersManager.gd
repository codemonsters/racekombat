extends Node
class_name ControllersManager

var _controllers: Array # of Controllers


func _init():
	_controllers = []


func add_controller(controller: Controller):
	_controllers.append(controller)
	print_debug("New controller added: " + controller.to_string())

func handle_input(event):
	for controller in _controllers:
		if controller.input(event):
			# get_tree().set_input_as_handled()
			break
			# Set input as handled no funciona. Mirarlo
