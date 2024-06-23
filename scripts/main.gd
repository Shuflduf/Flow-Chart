extends Node2D

func _process(_delta):
	if Global.active_node != null:
		Global.active_node.global_position = get_local_mouse_position() + Global.active_node.local_mouse_offset

func _ready():
	for child in get_children():
		if child is FlowChartNode:
			child.z_index = Global.node_count
			child.picked_up.connect(move_all_nodes_down)
			Global.node_count += 1
			Global.nodes_indicies.push_front(child.z_index)
	print(Global.nodes_indicies)

func move_all_nodes_down():
	Global.nodes_indicies.clear()
	for child in get_children():
		if child is FlowChartNode:
			Global.nodes_indicies.push_front(child.z_index)
			child.move_down()
