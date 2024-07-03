class_name Settings
extends Resource

@export var grid: bool
@export_range(0.0, 20.0, 0.5) var mouse_margin := 10.0
@export var grid_resolution := 25
@export var min_size := 64
@export var max_size := 512
@export_range(0.1, 2.0, 0.1) var zoom_sens := 1.1

func save() -> Dictionary:
	var save_dict := {
		"grid" : grid,
		"mouse_margin" : mouse_margin,
		"grid_resolution" : grid_resolution,
		"min_size" : min_size,
		"max_size" : max_size,
		"zoom_sens" : zoom_sens,
	}
	return save_dict
