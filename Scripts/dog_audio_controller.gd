extends Node

@onready var walk_sound   = $walk_sound
@onready var sprint_sound = $sprint_sound
@onready var jump_sound   = $jump_sound
@onready var panting_sound = $panting_sound
@onready var bark_sound = $bark_sound

var rng = RandomNumberGenerator.new()
var is_idle: bool = false
var idle_panting_timer: Timer = null
var previous_state_id: int = -1

func _ready():
	# Create and configure a Timer to trigger random panting while idle.
	idle_panting_timer = Timer.new()
	idle_panting_timer.wait_time = randf_range(4.0, 10.0)
	idle_panting_timer.timeout.connect(_on_idle_pant)
	add_child(idle_panting_timer)

func _on_eat_consumable():
	bark_sound.play()

func _jump():
	stop_all_sounds()
	jump_sound.play()

func _on_set_movement_state(_movement_state: MovementState) -> void:
	var new_state_id = _movement_state.id
	stop_all_sounds()  # Stop any currently playing sounds.

	match new_state_id:
		0: # Idle
			is_idle = true

			# If we came from sprinting, play panting immediately
			var should_play = rng.randf_range(0, 1) > 0.5
			if previous_state_id == 1 and should_play:
				panting_sound.play()

			# Always start random panting timer when idle
			idle_panting_timer.start(randf_range(4.0, 10.0))

		1: # Sprint
			panting_sound.stop()
			sprint_sound.play()

		2: # Walk
			# If we came from sprinting, play panting immediately
			# 50% chance
			var should_play = rng.randf_range(0, 1) > 0.5
			if previous_state_id == 1 and should_play:
				panting_sound.play()
				
			walk_sound.play()

		_:
			print("Invalid state: ", new_state_id)

	previous_state_id = new_state_id

func _on_idle_pant():
	if is_idle:
		if not panting_sound.playing:
			panting_sound.play()
		idle_panting_timer.start(randf_range(8.0, 15.0))

func stop_all_sounds():
	walk_sound.stop()
	sprint_sound.stop()
	#jump_sound.stop()
	#panting_sound.stop()
	is_idle = false
	if idle_panting_timer:
		idle_panting_timer.stop()
