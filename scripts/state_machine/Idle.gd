extends State
class_name Idle

@onready var idle_timer : Timer = $IdleTimer
var direction : Vector2

func enter():
	super()
	new_random_direction()
	
func exit():
	pass
	
func new_random_direction():
	direction = Vector2(randf_range(-1, 1), randf_range(-1, 1))
	direction = direction.normalized()

func process_physics(delta):
	parent.velocity = direction * parent.SPEED
	parent.move_and_slide()

func _on_idle_timer_timeout():
	new_random_direction()
	idle_timer.wait_time = randf_range(1,3)
	idle_timer.start()
