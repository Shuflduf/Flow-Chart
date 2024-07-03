class_name MouseMarginer
extends Node

var start_pos: Vector2
var enable_debug := false

func passed_threshold(pos: Vector2) -> bool:
	var length := (start_pos - pos).length()
	if enable_debug:
		print(length)
	if length > Global.settings.mouse_margin:
		return true
	else: 
		return false
