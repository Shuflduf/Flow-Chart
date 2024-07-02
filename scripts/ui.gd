extends Control

@export var chart: Control

func _on_new_node_pressed() -> void:
	chart.add_node()
	

func _on_save_chart_pressed() -> void:
	Global.save_chart()


func _on_load_chart_pressed() -> void:
	Global.load_chart()
