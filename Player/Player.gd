extends CharacterBody3D

signal pressed_jump()
signal on_set_movement_state(_movement_state: MovementState)
signal on_set_movement_direction(_movement_direction: Vector3)

@export var movementStates : Dictionary

var movement_direction : Vector3
var current_movement_state_name : String
var jumped : bool = false


func _ready():	
	on_set_movement_direction.emit(Vector3.BACK)
	set_movement_state("idle")

func _input(event):
	if event.is_action_pressed("movement") or event.is_action_released("movement"):
		movement_direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
		movement_direction.z = Input.get_action_strength("back") - Input.get_action_strength("forward")
		
		if is_movement_ongoing():
			if Input.is_action_pressed("sprint"):
				set_movement_state("sprint")
			else:
				set_movement_state("walk")
		else:
			set_movement_state("idle")
	
	if event.is_action_pressed("jump") and not jumped:
		jumped = true
		pressed_jump.emit()


func _physics_process(delta):
	if is_movement_ongoing():
		on_set_movement_direction.emit(movement_direction)
		
	jumped = not is_on_floor()


func is_movement_ongoing() -> bool:
	return abs(movement_direction.x) > 0 or abs(movement_direction.z) > 0


func set_movement_state(state : String):
	var movement_state = movementStates[state]
	on_set_movement_state.emit(movement_state)
