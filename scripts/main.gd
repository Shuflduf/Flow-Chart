extends Node2D

func _process(_delta):
	if Global.active_node != null:
		Global.active_node.global_position = get_local_mouse_position() + Global.mouse_offset

func _ready():
	for child in get_children():
		if child is FlowChartNode:
			child.z_index = Global.node_count
			child.picked_up.connect(move_all_nodes_down)
			Global.node_count += 1
	print(Global.node_count)

func move_all_nodes_down():
	for child in get_children():
		if child is FlowChartNode:
			child.z_index -= 1
