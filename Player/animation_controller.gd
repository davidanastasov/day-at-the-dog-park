extends Node

@export var animation_player : AnimationPlayer

func _jump():
	animation_player.play("jump")


func _on_set_movement_state(_movement_state : MovementState):
	match _movement_state.id:
		0:
			animation_player.play("idle")
		1:
			animation_player.play("sprint")
		2:
			animation_player.play("walk")
		_:
			print("Invalid state: ", _movement_state.id)
