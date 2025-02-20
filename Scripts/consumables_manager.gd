extends Node

var total_food = 0
var eaten_food = 0

signal on_eat_consumable()
signal all_consumables_eaten()

func _ready():
	# Automatically register all child consumables
	for child in get_children():
		if child.has_method("register_to_manager"):
			total_food += 1
			child.register_to_manager(self)

func _on_food_eaten():
	on_eat_consumable.emit()
	
	eaten_food += 1
	print("Food eaten! Progress: %d/%d" % [eaten_food, total_food])
	
	# Check if all food is eaten
	if eaten_food == total_food:
		all_consumables_eaten.emit()
