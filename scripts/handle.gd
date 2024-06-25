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
		
		if moving and Global.active_handle == null:
			Global.active_handle = self
			
func holding_down():
	return Input.is_action_pressed("mouse_left")
