extends Node

var active_node: FlowChartNode
var node_count := 0
var whos_on_top: Array[FlowChartNode]
var nodes_indicies: Array[int]
var active_pointer: Pointer

@export var settings: Settings = preload("res://resources/default_settings.tres")

func verify_on_top():
	await get_tree().process_frame
	var highest := -INF
	for i in whos_on_top:
		#print(i.z_index)
		if i.z_index > highest:
			highest = i.z_index
			active_node = i
			
	whos_on_top.clear()
	active_node.move_up()
