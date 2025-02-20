extends Control


func _ready():
	get_tree().paused = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_restart_button_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()
