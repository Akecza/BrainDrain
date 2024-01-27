extends State
class_name Following

var player : RigidBody2D

@export var next_state : State

func enter(player_ref):
	super(player_ref)
	player = player_ref
	
func exit():
	pass

func process_physics(delta):
	if (is_instance_valid(player)):
		var direction = parent.position.direction_to(player.position).normalized()
		parent.velocity = direction * parent.SPEED
		parent.move_and_slide()
	else:
		change_state.emit(next_state, null)

