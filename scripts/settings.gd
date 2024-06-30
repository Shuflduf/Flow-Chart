class_name Settings
extends Resource

@export var grid: bool
@export var mouse_margin := 10.0
@export var handles_mouse_margin := 5.0
@export var grid_resolution := 25
@export_range(0.1, 0.99) var drag_margins := 0.85
@export var min_size := 128
@export var max_size := 512
