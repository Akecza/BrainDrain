extends CharacterBody2D

@onready var timer : Timer = $Timer
@onready var happiness_bar : ProgressBar = $HappinessBar 
var direction : Vector2
const SPEED = 50.0
const JUMP_VELOCITY = -400.0
var BaseHappyDepleteSpeed = 5
var HappyDepleteAmount

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	HappyDepleteAmount=BaseHappyDepleteSpeed

func new_random_direction():
	direction = Vector2(randf_range(-1, 1), randf_range(-1, 1))
	direction = direction.normalized()

func _physics_process(delta):
	# Add the gravity.
	happiness_bar.value = happiness_bar.value - HappyDepleteAmount*delta
	
	velocity = direction * SPEED
	#velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func _on_timer_timeout():
	new_random_direction()
	timer.wait_time = randf_range(1,3)
	timer.start()
	
func make_happy(amount):
	happiness_bar.value = happiness_bar.value + amount
	if amount > 0:
		$HappyDepleteTimer.start()
		HappyDepleteAmount=0
	


func _on_hitbox_area_area_entered(area : Area2D):
	print(area.name)
	if (area.name == "Honk"):
		make_happy(10)
	if (area.name == "Whoopie"):
		print("SAD FART")
		make_happy(-50)
	if (area.name == "WhoopieSound"):
		print("YAY FART")
		make_happy(30)
	


func _on_happy_deplete_timer_timeout():
	HappyDepleteAmount = BaseHappyDepleteSpeed
