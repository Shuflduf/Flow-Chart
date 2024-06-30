extends Control

var grid_mover := GridMover.new()
var moving_chart := false
var mouse_offset: Vector2

var cam_zoom := 1.0

@onready var nodes: Control = $Nodes

func _process(_delta: float) -> void:
	
	
	if Global.active_node != null:
		Global.active_node._moved()
		var actual_pos := get_local_mouse_position() + Global.active_node.local_mouse_offset

		Global.active_node.global_position = grid_mover.move_grid(actual_pos)
		return
		
	if moving_chart:
		nodes.position = get_global_mouse_position() + mouse_offset

func _ready() -> void:
	for child in get_children():
		if child is FlowChartNode:
			child.z_index = Global.node_count
			child.picked_up.connect(func() -> void: move_all_nodes_down())
			Global.node_count += 1
			Global.nodes_indicies.push_front(child.z_index)

func move_all_nodes_down() -> void:
	Global.nodes_indicies.clear()
	for child in get_children():
		if child is FlowChartNode:
			Global.nodes_indicies.push_front(child.z_index)
			child.move_down()
	



func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("mouse_left"):
		mouse_offset = nodes.global_position - event.global_position
		var margin_handler := MouseMarginer.new()
		margin_handler.start_pos = mouse_offset
		
		while !moving_chart and Input.is_action_pressed("mouse_left"):
			await get_tree().process_frame
			if margin_handler.passed_threshold(get_local_mouse_position()):
				moving_chart = true
						
	if event.is_action_released("mouse_left"):
		moving_chart = false
		
	if event.is_pressed():
		match event.button_index:
			MOUSE_BUTTON_WHEEL_UP:
				nodes.scale += Vector2(0.1, 0.1)
			MOUSE_BUTTON_WHEEL_DOWN:
				nodes.scale -= Vector2(0.1, 0.1)
