extends Node
class_name ControllersManager

var _controllers: Array # of Controllers
var _main_controller: Controller	# Controlador principal (el que maneja la UI)


func _init():
	_controllers = []


func add_controller(controller: Controller):
	_controllers.append(controller)
	print_debug("New controller added: " + controller.to_string())


#func handle_input(event):
#	for controller in _controllers:
#		if controller.input(event):
#			# get_tree().set_input_as_handled()
#			break
#			# Set input as handled no funciona. Mirarlo

func controller_input(controller: Controller, action: String):
	# TODO: id no existe, _main_controller no está asignado, controller_input ni existe
	if controller.id == _main_controller.id:
		$currentScene.controller_input(controller, action, true)
	else:
		$currentScene.controller_input(controller, action, false)
