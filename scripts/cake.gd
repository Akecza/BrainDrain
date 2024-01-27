extends Area2D

var speedVector = Vector2(0,0)
var speed = 300
var rotateSpeed=0.1
var ySpeed=5

# Called when the node enters the scene tree for the first time.
func _ready():
	$CakeHappy/Happy.disabled=true
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += speedVector * speed * delta
	$CakeSprite.rotation-=rotateSpeed
	#position += transform.y * ySpeed * delta
	#ySpeed-=delta
	

func _on_body_entered(body):
	if body.is_in_group("Cakeables"):
		$CakeHappy/Happy.disabled=false
		print ("Ouch a cake")
	$HappyTimer.start()
	rotateSpeed=0
	speed=0


func _on_happy_timer_timeout():
	queue_free()


func _on_fly_time_timeout():
	speed=0
	rotation=0
	rotateSpeed=0
	$CakeSprite.visible=false
	$CakeFloorMush.visible=true
