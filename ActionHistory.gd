class_name ActionHistory

var is_being_pressed: bool = false
var pressed_time: Array = []
var released_time: Array = []

func _to_string():
	return "pressed" + var2str(pressed_time) + "\n" + "released" + var2str(released_time) + "\n" 
