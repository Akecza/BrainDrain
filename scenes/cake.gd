extends Area2D

var speed = 300

# Called when the node enters the scene tree for the first time.
func _ready():
	$HappyArea/Happy.disabled=true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += transform.x * speed * delta


func _on_body_entered(body):
	if body.is_in_group("Cakeables"):
		$HappyArea/Happy.disabled=false
	$HappyTimer.start()
	speed=0



func _on_happy_timer_timeout():
	queue_free()
