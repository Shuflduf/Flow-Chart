extends Control

@export var chart: Control

func _on_new_node_pressed() -> void:
	chart.add_node()
	
