class_name Pointer
extends Line2D

var start_pos: Handle
var end_pos: Handle

func create(one: Vector2, two: Vector2) -> PackedVector2Array:
	return PackedVector2Array([one, two])

func move_point(index: int, pos: Vector2) -> void:
	points[index] = pos
