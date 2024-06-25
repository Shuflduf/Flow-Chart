class_name Pointer
extends Line2D

var start_pos: Handle
var end_pos: Handle

func create(one, two):
	return PackedVector2Array([one, two])

func move_point(index, pos):
	points[index] = pos
