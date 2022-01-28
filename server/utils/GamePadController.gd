class_name GamePadController extends Controller

var _controllersManager: ControllersManager
var _id : int



func _init(controllersManager: ControllersManager, id: int):
	_controllersManager = controllersManager
	_id = id


func _to_string():
	return (
		   "GamePad Controller (id: " + str(_id))


func input(event:String, is_pressed:bool):
	if event == "A":
		event = "action"
	_controllersManager.controller_input(self, event, is_pressed)
	return true

func get_id():
	return _id

func get_class() : 
	return "GamePadController"
