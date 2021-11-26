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
			get_tree().set_input_as_handled()
			break
	# TODO: recorrer la lista de controllers y por cada controller que sea teclado comprobar si ese controller particular se encarga de atender este evento
