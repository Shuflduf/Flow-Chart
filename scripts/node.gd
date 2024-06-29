class_name FlowChartNode
extends Control

signal picked_up


@onready var text := %TextEdit
@onready var text_box := %TextBox
@onready var handles := $Handles

var local_mouse_offset: Vector2

func _ready() -> void:
	update_handles_position()
			
func _on_text_edit_gui_input(event: InputEventMouse) -> void:

	if event is InputEventMouse:
		_on_gui_input(event)
	
func _on_gui_input(event: InputEventMouse) -> void:
	if event.is_action_pressed("mouse_left"):
		local_mouse_offset = text_box.global_position - event.global_position
		var moving := false
		var temp : float
		while !moving and holding_down():
			await get_tree().process_frame
			temp = (local_mouse_offset - \
				(text_box.global_position - get_global_mouse_position())).length()
			moving = temp > Global.settings.mouse_margin
		
		if moving:
			pickup()
		else:
			enable_text_field()
			
	if event.is_action_released("mouse_left"):
		drop()
		
func pickup() -> void:
	disable_text_field()
	Global.whos_on_top.push_front(self)
	Global.verify_on_top()
		

func drop() -> void:
	Global.active_node = null
	#text.editable = true

func move_down() -> void:
	z_index -= 1
	clamp_zindex()

func move_up() -> void:
	picked_up.emit()
	z_index = Global.node_count
	clamp_zindex()
		
func clamp_zindex() -> void:
	z_index = clamp(z_index, -INF, Global.node_count)

func holding_down() -> bool:
	return Input.is_action_pressed("mouse_left")

func disable_text_field() -> void:
	text.editable = false
	
func enable_text_field() -> void:
	text.editable = true

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		disable_text_field()

func update_handles_position() -> void:
	var handles_children := handles.get_children()
	handles_children[0].position = Vector2(0, size.y / 2) - handles_children[0].size / 2
	handles_children[1].position = Vector2(size.x / 2, size.y) - handles_children[1].size / 2
	handles_children[2].position = Vector2(size.x, size.y / 2) - handles_children[2].size / 2
	handles_children[3].position = Vector2(size.x / 2, 0) - handles_children[3].size / 2
		
func _moved() -> void:
	for handle in handles.get_children():
		if handle is Handle:
			handle._node_moved()



