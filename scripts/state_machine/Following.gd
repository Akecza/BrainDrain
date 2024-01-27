extends State
class_name Following

var player : RigidBody2D

func enter(player_ref):
	super(player_ref)
	player = player_ref
	
func exit():
	pass

func process_physics(delta):
	var direction = parent.position.direction_to(player.position).normalized()
	parent.velocity = direction * parent.SPEED
	#parent.position = parent.transform.x * parent.SPEED * delta
	parent.move_and_slide()

