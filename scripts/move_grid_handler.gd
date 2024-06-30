class_name GridMover
extends Node

func move_grid(actual_pos: Vector2) -> Vector2:
	if Global.settings.grid:
		var grid_pos: Vector2i = actual_pos / Global.settings.grid_resolution
		grid_pos *= Global.settings.grid_resolution
		return grid_pos
	else:
		return actual_pos
