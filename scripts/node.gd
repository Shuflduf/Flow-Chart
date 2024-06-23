class_name FlowChartNode
extends Area2D

func _on_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("mouse_left"):
		print(Global.mouse_offset)
		Global.mouse_offset = -(event.position - global_position)
		
		if Global.active_node == self:
			Global.active_node = null
		
		elif Global.active_node == null:
			Global.active_node = self
		
		

