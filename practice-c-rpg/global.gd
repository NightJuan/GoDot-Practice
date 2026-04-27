extends Node

var class_choice = "null"
var turn_order = 0
var input = ""
var fighter = ""

func reward_one(role):
	# Convert the input to lowercase before checking
	var r = role.to_lower()
	
	if r == "fighter":
		return "Great Sword"
	elif r == "ranger":
		return "Reinforced Bow"
	elif r == "wizard":
		return "Great Staff"
	
	return "Unknown Item" # Good practice to have a fallback
