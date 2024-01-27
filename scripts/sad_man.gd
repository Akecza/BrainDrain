extends CharacterBody2D
class_name SadMan
signal happinessChanged

@onready var got_caked_timer = $GotCakedTimer
@onready var animations = $AnimatedSprite2D
@onready var state_machine = $StateMachine
@onready var timer : Timer = $Timer
@onready var happiness_bar : ProgressBar = $HappinessBar 

@onready var laughing_player : AudioStreamPlayer2D = $LaughingPlayer

const SPEED = 50.0
const JUMP_VELOCITY = -400.0
var BaseHappyDepleteSpeed = 5
var HappyDepleteAmount
var InInflatableRange

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	HappyDepleteAmount=BaseHappyDepleteSpeed
	$AnimatedSprite2D.play("default")
	state_machine.init(self)
	owner.SadManList.push_back(self)
#func new_random_direction():
	#direction = Vector2(randf_range(-1, 1), randf_range(-1, 1))
	#direction = direction.normalized()

func _physics_process(delta):
	happiness_bar.value = happiness_bar.value - HappyDepleteAmount*delta
	state_machine.process_physics(delta)
	check_happiness_state()
	if (InInflatableRange):
		make_happy(55*delta)
	if velocity.x>0:
		$AnimatedSprite2D.flip_h=true
	else:
		$AnimatedSprite2D.flip_h=false
	
func getHappinessValue():
	return $HappinessBar.value
	
#func _on_timer_timeout():
	#new_random_direction()
	#timer.wait_time = randf_range(1,3)
	#timer.start()
	
func make_happy(amount):
	happiness_bar.value = happiness_bar.value + amount
	if happiness_bar.value == 100:
		$HappyDepleteTimer.start()
		HappyDepleteAmount=0

func _on_hitbox_area_area_entered(area : Area2D):
	print(area.name)
	if (area.name == "Honk"):
		make_happy(10)
	if (area.name == "Whoopie"):
		make_happy(-50)
	if (area.name == "WhoopieSound"):
		make_happy(30)
	if (area.name == "CakeHappy" && got_caked_timer.time_left == 0):
		make_happy(50)
	if (area.name == "Joke"):
		state_machine.change_state($StateMachine/Following, area.get_parent())
	if (area.name == "JokeFinish"):
		make_happy(100)
	if (area.name == "InflatableSound"):
		state_machine.change_state($StateMachine/Following, area.get_parent())
		InInflatableRange=true

func _on_hitbox_area_area_exited(area):
	if (area.name == "Joke"):
		state_machine.change_state($StateMachine/Idle, null)
	if (area.name == "InflatableSound"):
		InInflatableRange=false

func _on_happy_deplete_timer_timeout():
	HappyDepleteAmount = BaseHappyDepleteSpeed

func check_happiness_state():
	if (happiness_bar.value == 100):
		state_machine.change_state($StateMachine/Laughing, null)

