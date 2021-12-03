class_name KeyboardController extends Controller


func _init(key_up: int, key_down: int, key_left: int, key_right: int, keys_action: Array).(key_up, key_down, key_left, key_right, keys_action):
	#Calls parent init function
	pass

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
	.input(event)
