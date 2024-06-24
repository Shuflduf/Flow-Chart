class_name FlowChartNode
extends Control

signal picked_up

@onready var text = %TextEdit

var local_mouse_offset: Vector2

func _on_gui_input(event):
	if event.is_action_pressed("mouse_left"):
		
		local_mouse_offset = -event.position
		print(local_mouse_offset)
		
		var moving := false
		while !moving and holding_down():
			await get_tree().process_frame
			moving = (local_mouse_offset + get_local_mouse_position()).length()\
				 > Global.settings.mouse_margin
		
		if moving:
			pickup()
		else:
			text.editable = true
			print("EDIT")
			
	if event.is_action_released("mouse_left"):
		drop()
		
func pickup():
	if Global.active_node == null:
		Global.whos_on_top.push_front(self)
		Global.verify_on_top()

func drop():
	Global.active_node = null

func move_down():
	z_index -= 1
	clamp_zindex()
	#print(Global.nodes_indicies)

func move_up():
	picked_up.emit()
	z_index = Global.node_count
	clamp_zindex()
		
func clamp_zindex():
	z_index = clamp(z_index, -INF, Global.node_count)

func holding_down():
	return Input.is_action_pressed("mouse_left")

func _on_text_edit_focus_exited():
	print("hg")
	text.editable = false

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		_on_text_edit_focus_exited()


func _on_text_edit_gui_input(event):
	if event is InputEventMouseButton:
		print("Gjkfg")



