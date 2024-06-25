class_name Handle
extends Panel

signal handle_grabbed

func _on_gui_input(event):
	if event.is_action_pressed("mouse_left"):
		#var local_mouse_offset = 
		
		var moving := false
		while !moving and holding_down():
			await get_tree().process_frame
			moving = (event.position - get_local_mouse_position()).length()\
				 > Global.settings.handles_mouse_margin
		
		if moving and Global.active_pointer == null:
			#Global.active_handle = self
			#print(name)
			var new_pointer = Pointer.new()
			
			
			# UNMAINTABLE CODE; fix this later
			var start_pos = get_parent().size.x
			
			new_pointer.points = new_pointer.create(-start_pos, get_local_mouse_position())
			new_pointer.default_color = Color.BLACK
			new_pointer.z_index = -4000
			call_deferred("add_child", new_pointer)
			
func holding_down():
	return Input.is_action_pressed("mouse_left")
