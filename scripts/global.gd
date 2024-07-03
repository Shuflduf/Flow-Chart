extends Node

var active_node: FlowChartNode

@export var settings: Settings = preload("res://resources/default_settings.tres")

signal finished_loading
var loading := false

func save_chart() -> void:
	var save_chart_file := FileAccess.open("user://save1.flchrt", FileAccess.WRITE)
	var save_nodes := get_tree().get_nodes_in_group("Persist")
	for node in save_nodes:
		if node.scene_file_path.is_empty():
			print("persistent node '%s' is not an instanced scene, skipped" % node.name)
			continue
		
		if !node.has_method("save"):
			print("persistent node '%s' is missing a save() function, skipped" % node.name)
			continue
		
		var node_data: Dictionary = node.call("save")
		
		var json_string := JSON.stringify(node_data)
		
		save_chart_file.store_line(json_string)


func load_chart() -> void:
	if not FileAccess.file_exists("user://save1.flchrt"):
		return
		
	for i in get_tree().get_nodes_in_group("Persist"):
		i.queue_free()
		
	loading = true
	var save_game := FileAccess.open("user://save1.flchrt", FileAccess.READ)
	while save_game.get_position() < save_game.get_length():
		## delay effect
		#for i in 10:
			#await get_tree().process_frame
		var json_string := save_game.get_line()

		# Creates the helper class to interact with JSON
		var json := JSON.new()

		# Check if there is any error while parsing the JSON string, skip in case of failure
		var parse_result := json.parse(json_string)
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			continue

		# Get the data from the JSON object
		var node_data: Dictionary = json.get_data()

		# Firstly, we need to create the object and add it to the tree and set its position.
		var new_object: Node = load(node_data["filename"]).instantiate()

		get_node(node_data["parent"]).call_deferred("add_child", new_object) #.add_child(new_object)

		
		if node_data.has("pos_x"):
			new_object.set_deferred("position", Vector2(node_data["pos_x"], node_data["pos_y"]))
			
			if new_object is FlowChartNode:
				new_object.set_deferred("size", Vector2(node_data["size_x"], node_data["size_y"]))
			
		if node_data.has("text"):
			new_object.set_text(node_data["text"])
			
			
		for i: StringName in node_data.keys():
			if i in ["filename", "parent", "pos_x", "pos_y", "size_x", "size_y", "text"]:
				continue
			new_object.set(i, node_data[i])
			
	finished_loading.emit()
	loading = false
			
