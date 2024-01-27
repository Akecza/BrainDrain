extends State
class_name Laughing

@export var next_state : State

func enter(player_ref):
	super(player_ref)
	
func exit():
	pass

func process_physics(delta):
	parent.velocity = Vector2.ZERO
	if (parent.happiness_bar.value < 100):
		change_state.emit(next_state, null)
