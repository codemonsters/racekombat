extends Node
class_name ControllersManager

var _controllers: Array # of Controllers
var _main_controller: Controller	# Controlador principal (el que maneja la UI)
var _main_node: Node2D


func _init(main_node: Node2D):
	_main_node = main_node
	_controllers = []

# TODO: input_keyboard
func input(event: InputEvent):
	for controller in _controllers:
		if controller.get_class() == ("KeyboardController"):
			if controller.input(event):
				return true
	return false

func input_gamepad(id, button, is_pressed):
	for controller in _controllers:
		if controller.get_class() == ("GamePadController") and id == controller.get_id():
			if controller.input(button, is_pressed):
				return true
	return false

func add_controller(controller: Controller):
	_controllers.append(controller)
	print_debug("New controller added: " + controller.to_string())


func controller_input(controller: Controller, action: String, is_pressed: bool):
	if _main_controller == null:
		_main_controller = controller
	
	if controller.get_instance_id() != _main_controller.get_instance_id():
		_main_node.get_node("CurrentScene").get_child(0).controller_input(controller, action, false, is_pressed)
	else:
		_main_node.get_node("CurrentScene").get_child(0).controller_input(controller, action, true, is_pressed)
