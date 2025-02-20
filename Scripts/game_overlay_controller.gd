extends Control

@onready var progressbar = $ProgressBar


func on_update_timer(value: float, max_time: float):
	progressbar.value = value / max_time * 100
	
