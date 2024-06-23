extends Node

var active_node: FlowChartNode
var mouse_offset: Vector2
var node_count := 0
var whos_on_top: Array[FlowChartNode]

func verify_on_top():
	var highest := -INF
	for i in whos_on_top:
		print(i.z_index)
		if i.z_index > highest:
			highest = i.z_index
			active_node = i
	whos_on_top.clear()
	active_node.move_up()
