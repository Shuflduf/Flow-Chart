class_name FlowChartNode
extends Control

signal picked_up

var hovering := false

@onready var text := %TextEdit
@onready var text_box := %MarginContainer
@onready var handles := $Handles
@onready var outline := %Outline

var local_mouse_offset: Vector2
var resizing := false

enum edges {
	T, B, L, R
}

var current_edge: edges

func _ready() -> void:
	update_handles_position()
		
			
func _on_text_edit_gui_input(event: InputEventMouse) -> void:
	if event is InputEventMouse:
		_on_gui_input(event)
	
	
func _on_gui_input(event: InputEventMouse) -> void:
	if event.is_action_pressed("mouse_left"):
		local_mouse_offset = text_box.global_position - event.global_position
		var moving := false
		var temp : float
		while !moving and holding_down():
			await get_tree().process_frame
			temp = (local_mouse_offset - \
				(text_box.global_position - get_global_mouse_position())).length()
			moving = temp > Global.settings.mouse_margin
		
		if moving:
			pickup()
		else:
			enable_text_field()
			
	if event.is_action_released("mouse_left"):
		drop()
	
		
func pickup() -> void:
	disable_text_field()
	Global.whos_on_top.push_front(self)
	Global.verify_on_top()
		

func drop() -> void:
	Global.active_node = null
	#text.editable = true


func move_down() -> void:
	z_index -= 1
	clamp_zindex()


func move_up() -> void:
	picked_up.emit()
	z_index = Global.node_count
	clamp_zindex()
	
		
func clamp_zindex() -> void:
	z_index = clamp(z_index, -INF, Global.node_count)


func holding_down() -> bool:
	return Input.is_action_pressed("mouse_left")


func disable_text_field() -> void:
	text.editable = false
	

func enable_text_field() -> void:
	text.editable = true


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		disable_text_field()


func update_handles_position() -> void:
	var handles_children := handles.get_children()
	handles_children[0].position = Vector2(0, size.y / 2) - handles_children[0].size / 2
	handles_children[1].position = Vector2(size.x / 2, size.y) - handles_children[1].size / 2
	handles_children[2].position = Vector2(size.x, size.y / 2) - handles_children[2].size / 2
	handles_children[3].position = Vector2(size.x / 2, 0) - handles_children[3].size / 2

		
func _moved() -> void:
	for handle in handles.get_children():
		if handle is Handle:
			handle._node_moved()


func _on_mouse_entered() -> void:
	hovering = true
	print("INjkhbfdkjg")

func _on_mouse_exited() -> void:
	hovering = false


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
		update_handles_position()
		_moved()
		#toggle_handles_texture(true)
			 	
		
	if event.is_action_pressed("mouse_left"):
		resizing = true
	
	if event.is_action_released("mouse_left"):
		resizing = false
		
		

		
