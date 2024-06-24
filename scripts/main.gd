extends Control

var actual_pos : Vector2
var grid_pos : Vector2i

func _process(_delta):
	if Global.active_node != null:
		actual_pos = get_local_mouse_position() + Global.active_node.local_mouse_offset
		if !Global.settings.grid:
			Global.active_node.global_position = actual_pos
		else:
			move_grid()

func _ready():
	get_tree().root.get_viewport().size_changed.connect(func(): _viewport_size_changed())
	
	for child in get_children():
		if child is FlowChartNode:
			child.z_index = Global.node_count
			child.picked_up.connect(move_all_nodes_down)
			Global.node_count += 1
			Global.nodes_indicies.push_front(child.z_index)

func move_all_nodes_down():
	Global.nodes_indicies.clear()
	for child in get_children():
		if child is FlowChartNode:
			Global.nodes_indicies.push_front(child.z_index)
			child.move_down()

func move_grid():
	grid_pos = actual_pos / Global.settings.grid_resolution
	Global.active_node.global_position = grid_pos * Global.settings.grid_resolution
		
func _on_gui_input(event):
	if event.is_action_pressed("mouse_left"):
		print("backround")
		for child in get_children():
			if child is FlowChartNode:
				child._on_text_edit_focus_exited()

func _viewport_size_changed():
	for child in get_children():
		if child is FlowChartNode:
			child.update_handles_position()
