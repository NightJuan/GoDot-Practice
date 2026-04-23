extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	# Waits for the frame to process before grabbing focus
	await get_tree().process_frame 
	$VBoxContainer/HBoxContainer/LineEdit.grab_focus()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
