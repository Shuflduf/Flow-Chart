class_name Handle
extends Panel

func _on_gui_input(event: InputEventMouse):
	if event.is_action_pressed("mouse_left"):
		#var local_mouse_offset = 
		
		var moving := false
		while !moving and holding_down():
			await get_tree().process_frame
			moving = (event.position - get_local_mouse_position()).length()\
				 > Global.settings.handles_mouse_margin
		
		if moving:
			#Global.active_handle = self
			#print(name)
			var new_pointer = Pointer.new()
			
			
			## UNMAINTABLE CODE; fix this later
			var start_pos = get_parent().size.x
			
			new_pointer.points = new_pointer.create(-start_pos, get_local_mouse_position())
			new_pointer.default_color = Color.BLACK
			new_pointer.z_index = -4000
			add_child(new_pointer)
			#call_deferred("add_child", new_pointer)
			Global.active_pointer = get_children()[-1]
			while holding_down():
				await get_tree().process_frame
				get_children()[-1].move_end(get_local_mouse_position())
		
		if event.is_action_released("mouse_left") and Global.active_pointer.start_pos != self:
			Global.active_pointer.end_pos = self
			print("JFG")
		else:
			Global.active_pointer.queue_free()
			
			
func holding_down():
	return Input.is_action_pressed("mouse_left")
