extends CharacterBody2D
class_name SadMan

@onready var animations = $AnimatedSprite2D
@onready var state_machine = $StateMachine
@onready var timer : Timer = $Timer
@onready var happiness_bar : ProgressBar = $HappinessBar 

const SPEED = 50.0
const JUMP_VELOCITY = -400.0
var BaseHappyDepleteSpeed = 5
var HappyDepleteAmount

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	HappyDepleteAmount=BaseHappyDepleteSpeed
	state_machine.init(self)

#func new_random_direction():
	#direction = Vector2(randf_range(-1, 1), randf_range(-1, 1))
	#direction = direction.normalized()

func _physics_process(delta):
	happiness_bar.value = happiness_bar.value - HappyDepleteAmount*delta
	state_machine.process_physics(delta)
	
#func _on_timer_timeout():
	#new_random_direction()
	#timer.wait_time = randf_range(1,3)
	#timer.start()
	
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
	if (area.name == "Cake"):
		make_happy(-100)
	if (area.name == "CakeHappy"):
		make_happy(50)


func _on_happy_deplete_timer_timeout():
	HappyDepleteAmount = BaseHappyDepleteSpeed
