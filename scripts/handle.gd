class_name Handle
extends Panel

var mouse_in_area := false:
	set(value):
		toggle_handles_texture(value)
		mouse_in_area = value
var pointer_ends: Array[Pointer]

const HANDLE_TEX = preload("res://resources/handle.tres")
const NO_TEXTURE = preload("res://resources/no_texture.tres")


func _on_gui_input(event: InputEventMouse) -> void:
	if event.is_action_pressed("mouse_left"):
		
		var moving := false
		var margin_handler := MouseMarginer.new()
		margin_handler.start_pos = global_position - event.global_position
		while !moving and holding_down():
			await get_tree().process_frame
			if margin_handler.passed_threshold(get_local_mouse_position()):
				moving = true
		
		if moving:
			var new_pointer := Pointer.new()
			
			new_pointer.points = new_pointer.create(Vector2.ZERO, get_local_mouse_position())
			new_pointer.default_color = Color.BLACK
			new_pointer.z_index = -4000
			new_pointer.start_pos = self
			new_pointer.begin_cap_mode = Line2D.LINE_CAP_ROUND
			new_pointer.end_cap_mode = Line2D.LINE_CAP_ROUND
			
			add_child(new_pointer)
			Global.active_pointer = get_children()[-1]
			while holding_down():
				await get_tree().process_frame
				Global.active_pointer.move_point(1, get_local_mouse_position())
			await get_tree().process_frame
			
			if Global.active_pointer != null:
				if Global.active_pointer.end_pos == null:
					nevermind_pointer_invalid_sowwy()
		
			
func holding_down() -> bool:
	return Input.is_action_pressed("mouse_left")


func _on_mouse_entered() -> void:
	mouse_in_area = true


func _on_mouse_exited() -> void:
	mouse_in_area = false


func _process(_delta: float) -> void:
	if mouse_in_area:
		if Input.is_action_just_released("mouse_left"):
			set_second_point()
			
			
func set_second_point() -> void:
	var handles_on_same_node := get_parent().get_children()
	if Global.active_pointer == null:
		return
	if Global.active_pointer.start_pos not in handles_on_same_node:
		Global.active_pointer.end_pos = self
		pointer_ends.push_back(Global.active_pointer)
		Global.active_pointer = null
	else:
		nevermind_pointer_invalid_sowwy()
		
		
func nevermind_pointer_invalid_sowwy() -> void:
	Global.active_pointer.queue_free()
	print('remove')
	
	
func _node_moved() -> void:
	for pointer in pointer_ends:
		pointer.move_point_to_handle(self)
		
	for pointer in get_children():
		pointer.update_pos()


func toggle_handles_texture(enable: bool) -> void:
	if enable:
		add_theme_stylebox_override("panel", HANDLE_TEX)
	else:
		add_theme_stylebox_override("panel", NO_TEXTURE)
