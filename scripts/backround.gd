extends Panel

@export var chart: Control

func _on_gui_input(event):
	if event.is_action_pressed("mouse_left"):
		for child in chart.get_children():
			if child is FlowChartNode:
				child._on_text_edit_focus_exited()

