extends RigidBody2D

@export var inflatable: PackedScene
@export var whoopie: PackedScene
@export var cake: PackedScene
@export var speed = 400 # How fast the player will move (pixels/sec).
@onready var honk = $Honk/HonkCollision
@onready var joke = $Joke/JokeCollision
@onready var joke_finished = $JokeFinish/JokeFinishCollision
@onready var joke_duration_timer = $JokeDuration
@onready var joke_cooldown_timer = $JokeCooldown
@onready var joke_finish_duration_timer = $JokeFinishDuration
@onready var whoopie_cooldown_timer = $WhoopieCooldownTimer
@onready var inflatable_cooldown_timer = $InflatableCooldownTimer

@onready var joke_player : AudioStreamPlayer2D = $JokePlayer
@export var honk_player: AudioStreamPlayer

@export var honk_button : Button
@export var cake_button : Button
@export var whoopie_button : Button
@export var joke_button : Button
@export var inflattable_button : Button
@export var baloon_button : Button

signal skill_changed

var screen_size # Size of the game window.
var honk_on_cooldown = false
var skillsAvailable = 1
var activeSkill = 1
var skillNames = ["Honk","Cake","Fart","Joke","Wobbly Man", "The Ultimate Joke"]

func _ready():
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	activateButtons()
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("walk_right"):
		velocity.x += 1
	if Input.is_action_pressed("walk_left"):
		velocity.x -= 1
	if Input.is_action_pressed("walk_down"):
		velocity.y += 1
	if Input.is_action_pressed("walk_up"):
		velocity.y -= 1
	if Input.is_action_pressed("skill1"):
		skill_honk()
	if Input.is_action_pressed("shoot"):
		useActiveSkill()
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	linear_velocity=velocity
	$Hand.look_at(get_global_mouse_position())
	if $Hand.rotation>180:
		transform.inverse()
		
func _input(event):
	if event.is_action_pressed("skill_up"):
		changeSkill(activeSkill+1)
	if event.is_action_pressed("skill_down"):
		changeSkill(activeSkill-1)

func useActiveSkill():
	if activeSkill==1:
		skill_honk()
	if activeSkill==2:
		shoot()
	if activeSkill==3:
		skill_whoopie()
	if activeSkill==4:
		skill_joke()
	if activeSkill==5:
		skill_inflatable()
	if activeSkill==6:
		pass
	
func skill_honk():
	if(not honk_on_cooldown):
		honk_on_cooldown=true
		$HonkCooldown.start()
		honk.disabled=false
		$HonkDuration.start()
		honk_player.play()

func shoot():
	if $ShootCooldown.is_stopped():
		$ShootCooldown.start()
		var shootAngle = $Hand/Nuzzle.global_position - $Hand/Center.global_position
		shootAngle=shootAngle.normalized()
		var b=cake.instantiate()
		owner.add_child(b)
		b.position=$Hand/Nuzzle.global_position
		b.speedVector=shootAngle
		
func skill_joke():
	if(joke_cooldown_timer.time_left == 0):
		joke_player.play()
		joke_cooldown_timer.start()
		joke.disabled=false
		#joke_duration_timer.start()
		
func skill_joke_finished():
	joke_finished.disabled=false
	joke.disabled=true
	joke_finish_duration_timer.start()
	
func _on_joke_finish_duration_timeout():
	joke_finished.disabled=true

func skill_whoopie():
	if(whoopie_cooldown_timer.time_left == 0):
		whoopie_cooldown_timer.start()
		var instance=whoopie.instantiate()
		owner.add_child(instance)
		instance.position=position
		
func skill_inflatable():
	if(inflatable_cooldown_timer.time_left == 0):
		inflatable_cooldown_timer.start()
		var instance=inflatable.instantiate()
		owner.add_child(instance)
		instance.position=position

func _on_skill_cooldown_timeout():
	honk_on_cooldown=false

func _on_skill_duration_timeout():
	honk.disabled=true

func changeSkill(a):
	activeSkill=a
	if activeSkill==0:
		activeSkill=skillsAvailable
	if activeSkill>skillsAvailable:
		activeSkill=1
	print("skillchanged")
	skill_changed.emit()
	disableAllHands()
	if activeSkill==1:
		$Hand/HandHonk.visible =true
	if activeSkill==2:
		$Hand/HandCake.visible =true
	if activeSkill==3:
		$Hand/HandFart.visible =true
	if activeSkill==4:
		$Hand/HandJoke.visible =true
	if activeSkill==5:
		$Hand/HandInflatable.visible =true
	if activeSkill==6:
		$Hand/HandJoke.visible =true

func disableAllHands():
	$Hand/HandInflatable.visible =false
	$Hand/HandCake.visible =false
	$Hand/HandFart.visible =false
	$Hand/HandHonk.visible =false
	$Hand/HandJoke.visible =false

func activateButtons():
	cake_button.disabled=true
	whoopie_button.disabled=true
	joke_button.disabled=true
	inflattable_button.disabled=true
	baloon_button.disabled=true
	
	if activeSkill > skillsAvailable: 
		activeSkill=1
	if skillsAvailable > 1:
		cake_button.disabled=false
	if skillsAvailable > 2:
		whoopie_button.disabled=false
	if skillsAvailable > 3:
		joke_button.disabled=false
	if skillsAvailable > 4:
		inflattable_button.disabled=false
	if skillsAvailable > 5:
		baloon_button.disabled=false
		
	if activeSkill == 1:
		honk_button.grab_focus()
	if activeSkill == 2:
		cake_button.grab_focus()
	if activeSkill == 3:
		whoopie_button.grab_focus()
	if activeSkill == 4:
		joke_button.grab_focus()
	if activeSkill == 5:
		inflattable_button.grab_focus()
	if activeSkill == 6:
		baloon_button.grab_focus()



