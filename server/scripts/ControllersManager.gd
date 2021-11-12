extends Node
class_name ControllersManager

var controllers: Array # of Controllers


func _init():
	controllers = [Controller.new()]
