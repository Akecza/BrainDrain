extends Node2D

@onready var cake_happy_collision = $CakeHappy/CakeHappyCollision
var speedVector = Vector2(0,0)
var fallVector = Vector2(0,2)
var speed = 400
var rotateSpeed=0.1

# Called when the node enters the scene tree for the first time.
func _ready():
	cake_happy_collision.set_deferred("disabled", true)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += speedVector * speed * delta
	speedVector += fallVector * delta
	$CakeSprite.rotation = speedVector.angle()+90
	

func _on_body_entered(body):
	if body.is_in_group("Cakeables"):
		cake_happy_collision.set_deferred("disabled", false)
		print ("Ouch a cake")
	body.make_happy(-200)
	$CakeSprite.visible=false
	$CakeFloorMush.visible=true
	$CakeFloorMush.rotation=$CakeSprite.rotation
	$CakeFloorMush.rotation+=20
	$HappyTimer.start()
	rotateSpeed=0
	speed=0
	fallVector = Vector2(0,0)


func _on_happy_timer_timeout():
	queue_free()


func _on_fly_time_timeout():
	speed=0
	#rotation=0
	rotateSpeed=0
	$CakeSprite.visible=false
	$CakeFloorMush.visible=true
