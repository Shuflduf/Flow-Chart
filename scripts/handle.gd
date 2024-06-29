class_name Handle
extends Panel

var mouse_in_area := false

func _on_gui_input(event: InputEventMouse) -> void:
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
			var new_pointer := Pointer.new()
			
			
			## UNMAINTABLE CODE; fix this later
			var start_pos : Vector2 = get_parent().size
			
			new_pointer.points = new_pointer.create(Vector2.ZERO, get_local_mouse_position())
			new_pointer.default_color = Color.BLACK
			new_pointer.z_index = -4000
			new_pointer.start_pos = self
			
			add_child(new_pointer)
			#call_deferred("add_child", new_pointer)
			Global.active_pointer = get_children()[-1]
			while holding_down():
				await get_tree().process_frame
				Global.active_pointer.move_point(1, get_local_mouse_position())
			await get_tree().process_frame
			if Global.active_pointer != null:
				if Global.active_pointer.end_pos == null:
					nevermind_pointer_invalid_sowwy()
		
	#if Global.active_pointer == null
			 #and Global.active_pointer.start_pos != self:
		#if event.is_action_released("mouse_left"):
			#Global.active_pointer.end_pos = self
			#print("JFG")
	#else:
		#Global.active_pointer.queue_free()
			
			
func holding_down() -> bool:
	return Input.is_action_pressed("mouse_left")


func _on_mouse_entered() -> void:
	mouse_in_area = true

func _on_mouse_exited() -> void:
	mouse_in_area = false

func _process(_delta: float) -> void:
	if mouse_in_area:
		if Input.is_action_just_released("mouse_left"):
			set_second_point()
			
func set_second_point() -> void:
	if Global.active_pointer.start_pos != self:
		Global.active_pointer.end_pos = self
		print("funy")
	else:
		Global.active_pointer.queue_free()

func nevermind_pointer_invalid_sowwy() -> void:
	Global.active_pointer.queue_free()
