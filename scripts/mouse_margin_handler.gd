class_name MouseMarginer
extends Node

var start_pos: Vector2

func passed_threshold(pos: Vector2) -> bool:
	if (start_pos + pos).length() > Global.settings.mouse_margin:
		return true
	else: 
		return false
