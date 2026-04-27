extends Control

signal	entered_pressed
signal	class_selected
signal	stage_ended

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$VBoxContainer/Input.grab_focus()
	display_text("Welcome Travelor, Choose a Class: \n	1. Fighter\n	2. Ranger\n	3. Wizard")
	
	await entered_pressed
	class_selection_flow()
	
	await class_selected
	display_text("You have Chossen a {c}\n Great Choice".format({"c":global.class_choice}))
	await get_tree().create_timer(2.0).timeout
	stage_one_flow()

func display_text(text):
	$VBoxContainer/Message.text = text

func input_grabber():
	global.input = $VBoxContainer/Input.text
	$VBoxContainer/Input.text = ""

func class_selection_flow():
	while true:
		await entered_pressed
		var choice = global.input.to_lower()
		
		if choice in ["1", "fighter"]:
			global.class_choice = "Fighter"
			break
		elif choice in ["2", "ranger"]:
			global.class_choice = "Ranger"
			break
		elif choice in ["3", "wizard"]:
			global.class_choice = "Wizard"
			break
		else:
			show_error_feedback()

func stage_one_flow():
	display_text("You have been chosen by the KING to slay the GOBLIN KING.\n" +
				 "As you travel, you spot a flipped Merchant Wagon.\n" +
				 "What do you do:\n1. Help the Merchant\n2. Steal the loot")
	
	while true:
		await entered_pressed
		var choice = global.input.to_lower()
		
		if choice in ["1", "help", "help them"]:
			event_one()
			break
		elif choice in ["2", "steal", "steal the loot"]:
			battle_one()
			break
		else:
			show_error_feedback()
	
	stage_ended.emit()

func show_error_feedback():
	$VBoxContainer/Input.placeholder_text = "NOT A CHOICE"
	await get_tree().create_timer(1.0).timeout
	$VBoxContainer/Input.placeholder_text = "Type Anything"

func event_one():
	var reward = global.reward_one(global.class_choice)
	display_text("You help the merchant and he gives you a {r}".format({"r": reward}))

func battle_one():
	pass


func _input(_event):
	if (Input.is_action_just_pressed("ui_text_newline") and not $VBoxContainer/Input.text.is_empty()):
		input_grabber()
		entered_pressed.emit()
