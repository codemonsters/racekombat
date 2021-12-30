class_name KeyboardController extends Controller

var _controllersManager: ControllersManager
var _key_up: int
var _key_down: int
var _key_left: int
var _key_right: int
var _keys_action: Array


func _init(controllersManager: ControllersManager, key_up: int, key_down: int, key_left: int, key_right: int, keys_action: Array):
	_controllersManager = controllersManager
	_key_up = key_up
	_key_down = key_down
	_key_left = key_left
	_key_right = key_right
	_keys_action = keys_action


func _to_string():
	var action_keys_names = ""
	for key in _keys_action:
		action_keys_names += ", " + OS.get_scancode_string(key)

	return (
		   "Keyboard Controller (" +
		   OS.get_scancode_string(_key_up) + ", " +
		   OS.get_scancode_string(_key_down) + ", " +
		   OS.get_scancode_string(_key_left) + ", " +
		   OS.get_scancode_string(_key_right) +
		   action_keys_names +
		   ")"
	)


func input(event: InputEvent):
	if event is InputEventKey:
		if event.scancode == _key_up:
			_controllersManager.controller_input(self, "up", event.pressed)
		elif event.scancode == _key_down:
			_controllersManager.controller_input(self, "down", event.pressed)
		elif event.scancode == _key_left:
			_controllersManager.controller_input(self, "left", event.pressed)
		elif event.scancode == _key_right:
			_controllersManager.controller_input(self, "right", event.pressed)
		elif event.scancode in _keys_action:
			_controllersManager.controller_input(self, "action", event.pressed)
		else:
			return false
		return true



func get_class() : 
	return "KeyboardController"
