extends Control

var grid_mover := GridMover.new()
var moving_chart := false
var mouse_offset: Vector2

var cam_zoom := 1.0

@onready var nodes: Control = $Nodes

const CHART_NODE = preload("res://scenes/node.tscn")

func _process(_delta: float) -> void:
	if Global.active_node != null:
		Global.active_node._moved()
		var actual_pos := get_local_mouse_position() + Global.active_node.local_mouse_offset

		Global.active_node.global_position = grid_mover.move_grid(actual_pos)
		return
		
	if moving_chart:
		nodes.position = get_global_mouse_position() + mouse_offset


func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("mouse_left"):
		mouse_offset = nodes.global_position - event.global_position
		var margin_handler := MouseMarginer.new()
		margin_handler.start_pos = mouse_offset
		
		while !moving_chart and Input.is_action_pressed("mouse_left"):
			await get_tree().process_frame
			if margin_handler.passed_threshold(get_local_mouse_position()):
				moving_chart = true
		return
						
	if event.is_action_released("mouse_left"):
		moving_chart = false
		return
		
	if event is InputEventMouse:
		if event.is_pressed() and not event.is_echo():
			var mouse_position: Vector2 = event.global_position
			match event.button_index:
				MOUSE_BUTTON_WHEEL_UP:
					_zoom_at_point(Global.settings.zoom_sens, mouse_position)
				MOUSE_BUTTON_WHEEL_DOWN:
					_zoom_at_point(1 / Global.settings.zoom_sens, mouse_position)


func _zoom_at_point(zoom_change: float, mouse_position: Vector2) -> void:
	if (!nodes.scale > Vector2(10, 10) or zoom_change < 1)\
			and (!nodes.scale < Vector2(0.2, 0.2) or zoom_change > 1):
		nodes.scale = nodes.scale * zoom_change
		var delta := (mouse_position - nodes.global_position) * (zoom_change - 1)
		nodes.global_position = nodes.global_position - delta
		
		
func add_node() -> void:
	var new_node := CHART_NODE.instantiate()
	new_node.global_position = Vector2.ZERO
	nodes.add_child(new_node)

	

