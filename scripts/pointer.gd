class_name Pointer
extends Line2D

const CENTER = Vector2(8, 8)

var start_pos: Handle:
	set(value):
		move_point_to_handle(value, true)
		start_pos = value
		
var end_pos: Handle:
	set(value):
		move_point_to_handle(value)
		end_pos = value

func create(one: Vector2, two: Vector2) -> PackedVector2Array:
	return PackedVector2Array([one, two])

func move_point(index: int, pos: Vector2) -> void:
	points[index] = pos

func move_point_to_handle(handle: Handle, first_point := false) -> void:
	if first_point:
		move_point(0, CENTER)
	else:
		move_point(1, handle.global_position - global_position + CENTER)

func update_pos() -> void:
	move_point_to_handle(end_pos)

func _process(_delta: float) -> void:
	print(start_pos)



