class_name Settings
extends Resource

@export var grid: bool
@export_range(0.0, 20.0, 0.5) var mouse_margin := 10.0
@export var grid_resolution := 25
@export var min_size := 64
@export var max_size := 512
@export var inverse_scroll := false
@export_range(0.0, 1.0, 0.1) var zoom_sens := 1.1
@export var load_default := true
