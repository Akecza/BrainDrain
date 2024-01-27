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

var screen_size # Size of the game window.
var honk_on_cooldown = false
var skillsAvailable = 2
var activeSkill = 1


func _ready():
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
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
	
func useActiveSkill():
	shoot()
	
func skill_honk():
	if(not honk_on_cooldown):
		honk_on_cooldown=true
		$HonkCooldown.start()
		honk.disabled=false
		$HonkDuration.start()

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







