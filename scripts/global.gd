extends Node

var active_node: FlowChartNode
var mouse_offset: Vector2
var node_count := 0
var whos_on_top: Array[FlowChartNode]:
	set(value):
		var highest: int
		for i in value:
			if i.z_index > highest:
				highest = i.z_index
				active_node = i
		whos_on_top.clear()
			

