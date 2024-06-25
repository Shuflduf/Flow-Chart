class_name Pointer
extends Line2D

var start_pos: Handle
var end_pos: Vector2:
	set(value):
		points[1] = value
	get:
		return end_pos

func create(one, two):
	return PackedVector2Array([one, two])
