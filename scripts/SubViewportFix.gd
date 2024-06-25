extends SubViewport

func _ready():
	# Bypass for issue #56502
	await get_tree().process_frame
	set_input_as_handled()
	
	#handle_input_locally = true
