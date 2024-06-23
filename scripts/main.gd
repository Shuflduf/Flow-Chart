extends Node2D


func _process(delta):
	if Global.active_node != null:
		Global.active_node.global_position = get_local_mouse_position() + Global.mouse_offset

