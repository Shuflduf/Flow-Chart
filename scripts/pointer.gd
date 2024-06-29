class_name Pointer
extends Line2D

var start_pos: Handle:
	set(value):
		move_point_to_center(value, true)
var end_pos: Handle:
	set(value):
		move_point_to_center(value)

func create(one: Vector2, two: Vector2) -> PackedVector2Array:
	return PackedVector2Array([one, two])

func move_point(index: int, pos: Vector2) -> void:
	points[index] = pos

func move_point_to_center(handle: Handle, first_point := false) -> void:
	var center := handle.size / 2
	if first_point:
		move_point(0, center)
	else:
		move_point(1, handle.global_position - global_position + center)
