class_name GamePadController extends Controller

var _controllersManager: ControllersManager
var _id : int
var states : Array



func _init(controllersManager: ControllersManager, id: int):
	_controllersManager = controllersManager
	_id = id
	states = ["left", false, "right", false, "up", false, "down", false, "action", false]

func _to_string():
	return (
		   "GamePad Controller (id: " + str(_id))


func input(event:String, is_pressed:bool):
	if event == "A":
		event = "action"
	var index = states.find(event)
	if not bool(states[index + 1]) == is_pressed:
		_controllersManager.controller_input(self, event, is_pressed)
		states[index + 1] = is_pressed
		print("Event: " + event + " is " + str(is_pressed) + " executed.")
	return true

func get_id():
	return _id

func get_class() : 
	return "GamePadController"
