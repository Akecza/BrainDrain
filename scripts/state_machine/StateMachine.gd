extends Node

@export var starting_state : State
var current_state : State

func init(parent) -> void:
	for child : State in get_children():
		child.parent = parent
		child.change_state.connect(change_state)
	change_state(starting_state, null)

func change_state(new_state : State, player_ref):
	if current_state:
		current_state.exit()
	
	if (new_state != current_state):
	#state lock jak się śmieje
		current_state = new_state
		current_state.enter(player_ref)

func process_physics(delta):
	var new_state = current_state.process_physics(delta)
	if new_state:
		change_state(new_state, null)
