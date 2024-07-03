class_name FlowChartNode
extends Control

signal picked_up

var hovering := false

@onready var text := %TextEdit
@onready var outline := %Outline

var local_mouse_offset: Vector2
var resizing := false

enum edges {
	T, B, L, R
}

var current_edge: edges

func save() -> Dictionary:
	var save_dict := {
		"filename" : get_scene_file_path(),
		"parent" : get_parent().get_path(),
		"pos_x" : position.x,
		"pos_y" : position.y,
		"size_x" : size.x,
		"size_y" : size.y,
		"text" : %TextEdit.text,
	}
	return save_dict


func set_text(input_text: String) -> void:
	await Global.finished_loading
	%TextEdit.text = input_text

			
func _on_text_edit_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		_on_gui_input(event)
	
	
func _on_gui_input(event: InputEventMouse) -> void:
	if event.is_action_pressed("mouse_left"):
		local_mouse_offset = global_position - event.global_position
		#print(local_mouse_offset)
		var moving := false
		var margin_handler := MouseMarginer.new()
		margin_handler.start_pos = local_mouse_offset
		while !moving and holding_down():
			await get_tree().process_frame
			if margin_handler.passed_threshold(global_position - get_global_mouse_position()):
				moving = true
		
		if moving:
			pickup()
		else:
			enable_text_field()
		return
			
	if event.is_action_released("mouse_left"):
		drop()
		return
	
	if event.is_action_pressed("delete"):
		queue_free()
		
		
func pickup() -> void:
	disable_text_field()
	get_parent().move_child(self, -1)
	Global.active_node = self

		
func drop() -> void:
	Global.active_node = null


func holding_down() -> bool:
	return Input.is_action_pressed("mouse_left")


func disable_text_field() -> void:
	text.editable = false
	

func enable_text_field() -> void:
	text.editable = true


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		disable_text_field()

		
func _on_margin_container_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		var offset: Vector2 = event.position
		
		offset -= outline.size / 2
		offset /= outline.size
		offset *= 2
		
		if !resizing:
			if abs(offset.x) > abs(offset.y):
				outline.mouse_default_cursor_shape = CURSOR_HSIZE
				current_edge = edges.L if offset.x < 0 else edges.R
			else:
				outline.mouse_default_cursor_shape = CURSOR_VSIZE
				current_edge = edges.T if offset.y < 0 else edges.B
		
			
		if resizing:
			var grid_mover := GridMover.new()
			get_parent().move_child(self, -1)
			match current_edge:
				edges.T:
					size.y -= grid_mover.move_grid(get_local_mouse_position()).y
					position.y += grid_mover.move_grid(get_local_mouse_position()).y
				edges.B:
					size.y = grid_mover.move_grid(get_local_mouse_position()).y
				edges.L:
					size.x -= grid_mover.move_grid(get_local_mouse_position()).x
					position.x += grid_mover.move_grid(get_local_mouse_position()).x
				edges.R:
					size.x = grid_mover.move_grid(get_local_mouse_position()).x
			
		
			
		size.x = clamp(size.x, Global.settings.min_size, Global.settings.max_size)	
		size.y = clamp(size.y, Global.settings.min_size, Global.settings.max_size)	
			 	
		
	if event.is_action_pressed("mouse_left"):
		resizing = true
	
	if event.is_action_released("mouse_left"):
		resizing = false
		
		

		
