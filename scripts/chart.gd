extends Control

var actual_pos : Vector2
var grid_pos : Vector2i

func _process(_delta: float) -> void:
	if Global.active_node != null:
		Global.active_node._moved()
		actual_pos = get_local_mouse_position() + Global.active_node.local_mouse_offset
		
		if !Global.settings.grid:
			Global.active_node.global_position = actual_pos
		else:
			move_grid()

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

func move_grid() -> void:
	grid_pos = actual_pos / Global.settings.grid_resolution
	Global.active_node.global_position = grid_pos * Global.settings.grid_resolution
	
