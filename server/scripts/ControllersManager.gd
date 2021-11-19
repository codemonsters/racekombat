extends Node
class_name ControllersManager

var _controllers: Array # of Controllers


func _init():
	_controllers = []


func add_controller(controller: Controller):
	_controllers.append(controller)
	print("New controller added: " + controller.to_string())
