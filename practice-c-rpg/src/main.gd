extends Control

signal	entered_pressed
signal	class_selected

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$VBoxContainer/Input.grab_focus()
	display_text("Welcome Travelor, Choose a Class: \n	1. Fighter\n	2. Ranger\n	3. Wizard")
	
	await entered_pressed
	class_selection(global.input)
	
	await class_selected
	display_text("You have Chossen a {c}".format({"c":global.class_choice}))
	await get_tree().create_timer(3.0).timeout
	display_text("")

func display_text(text):
	$VBoxContainer/Message.text = text

func input_grabber():
	global.input = $VBoxContainer/Input.text
	$VBoxContainer/Input.text = ""

func class_selection(text_input):
	
	var current_input = text_input.strip_edges()
	while true:
		if current_input == "1" or current_input.to_lower() == "fighter":
			global.class_choice = "Fighter"
			print("fighter")
			break
		elif current_input == "2" or current_input.to_lower() == "ranger":
			global.class_choice = "Ranger"
			print("ranger")
			break
		elif current_input == "3" or current_input.to_lower() == "wizard":
			global.class_choice = "Wizard"
			print("wizard")
			break
		else:
			$VBoxContainer/Input.placeholder_text = "NOT A CHOICE"
			await get_tree().create_timer(1.0).timeout
			$VBoxContainer/Input.placeholder_text = "Type Anything"
		await entered_pressed
		current_input = global.input.strip_edges()
	await get_tree().process_frame # Waits 1 frame so _ready can start its await
	class_selected.emit()
	print("class_selection ended")

func _input(event):
	if (Input.is_action_just_pressed("ui_text_newline") and not $VBoxContainer/Input.text.is_empty()):
		input_grabber()
		entered_pressed.emit()
