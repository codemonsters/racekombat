class_name KeyboardController extends Controller


var _key_up: int
var _key_down: int
var _key_left: int
var _key_right: int
var _keys_action: Array


func _init(key_up: int, key_down: int, key_left: int, key_right: int, keys_action: Array):
	_key_up = key_up
	_key_down = key_down
	_key_left = key_left
	_key_right = key_right
	_keys_action = keys_action


func _to_string():
	return (
		   "Keyboard Controller (" + 
		   OS.get_scancode_string(_key_up) + ", " +
		   OS.get_scancode_string(_key_down) + ", " +
		   OS.get_scancode_string(_key_left) + ", " +
		   OS.get_scancode_string(_key_right) +
		   ")"
	)


func input(event):
	print("Recibí")
