extends Node

@onready var success_screen = preload("res://UI/success_overlay.tscn")
@onready var failure_screen = preload("res://UI/failure_overlay.tscn")

signal on_update_timer(time: float, max_time: float)

var max_time: float = 60.0 # 60 seconds timer
var time_left: float = max_time
var timer_running: bool = true

func _process(delta):
	if timer_running:
		time_left -= delta
		if time_left <= 0:
			time_left = 0
			timer_running = false
			on_game_failed()

		on_update_timer.emit(time_left, max_time)

func _input(event):
	if event.is_action_pressed("restart"):
		get_tree().reload_current_scene()

func show_success_screen():
	print("All food collected! Show success screen.")
	var screen_instance = success_screen.instantiate()
	add_child(screen_instance)
	
func on_game_completed():
	show_success_screen()
	
func on_game_failed():
	var screen_instance = failure_screen.instantiate()
	add_child(screen_instance)
	print("Game failed! Restart")
