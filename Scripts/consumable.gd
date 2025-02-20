extends Area3D

var manager = null

signal food_eaten()

func _ready():
	body_entered.connect(_on_body_entered)
	
func register_to_manager(food_manager):
	manager = food_manager
	food_eaten.connect(manager._on_food_eaten)

func _on_body_entered(body):
	if body.is_in_group("player"):
		food_eaten.emit()
		queue_free()
