class_name FlowChartNode
extends Area2D

signal picked_up

func _on_input_event(_viewport, event: InputEvent, _shape_idx):
	if event.is_action_pressed("mouse_left"):
		Global.mouse_offset = -(event.position - global_position)
		pickup()
			
	if event.is_action_released("mouse_left"):
		drop()
		
func pickup():
	if Global.active_node == null:
		Global.whos_on_top.push_front(self)
		Global.verify_on_top()
		
	#if Global.active_node == null:
		#await get_tree().physics_frame
		#Global.active_node = self
		#print(z_index)
		#if z_index != Global.node_count:
			#picked_up.emit()
			#z_index = Global.node_count

func drop():
	if Global.active_node == self:
		Global.active_node = null

func move_down():
	z_index -= 1
	clamp_zindex()

func move_up():
	z_index += Global.node_count
	picked_up.emit()
	clamp_zindex()
		
func clamp_zindex():
	z_index = clamp(z_index, 0, Global.node_count)
