class_name Pointer
extends Panel

const CENTER = Vector2(8, 8)

var start_pos: Handle:
	set(value):
		start_pos = value
		global_position = value.global_position
		
var end_pos: Handle:
	set(value):
		move_end_to_handle(value)
		end_pos = value


func move_end(pos: Vector2) -> void:
	size.x = pos.length() + 10
	var dir_to_look := pos.angle()
	rotation = dir_to_look

func move_end_to_handle(handle: Handle) -> void:
	move_end(handle.global_position - get_parent().global_position)

func update_pos() -> void:
	move_end_to_handle(end_pos)




