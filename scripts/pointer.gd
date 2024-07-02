class_name Pointer
extends Panel

const CENTER = Vector2(8, 8)

var start_pos: Handle:
	set(value):
		start_pos = value
		global_position = value.global_position
		#move_end(end_pos.position)
		
var end_pos: Handle:
	set(value):
		move_end_to_handle(value)
		end_pos = value

func save() -> Dictionary:
	var save_dict := {
		"filename" : get_scene_file_path(),
		"parent" : get_parent().get_path(),
		"start_pos" : start_pos,
		"end_pos" : end_pos
	}
	return save_dict


func move_end(pos: Vector2) -> void:
	size.x = pos.length() + 10
	var dir_to_look := pos.angle()
	rotation = dir_to_look

func move_end_to_handle(handle: Handle) -> void:
	move_end(handle.global_position - get_parent().global_position)

func update_pos() -> void:
	global_position = start_pos.global_position
	move_end_to_handle(end_pos)


func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("delete"):
		end_pos.pointer_ends.erase(self)
		queue_free()
