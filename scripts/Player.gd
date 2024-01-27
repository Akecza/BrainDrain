extends RigidBody2D
@export var cake: PackedScene
@export var speed = 400 # How fast the player will move (pixels/sec).
@onready var honk = $Honk/HonkCollision
var screen_size # Size of the game window.
var honk_on_cooldown = false



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
		shoot()

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	linear_velocity=velocity
	$Hand.look_at(get_global_mouse_position())

func skill_honk():
	if(not honk_on_cooldown):
		honk_on_cooldown=true
		$HonkCooldown.start()
		honk.disabled=false
		$HonkDuration.start()

func shoot():
	if $ShootCooldown.is_stopped():
		$ShootCooldown.start()
		var b=cake.instantiate()
		owner.add_child(b)
		b.transform=$Hand.global_transform

func _on_skill_cooldown_timeout():
	honk_on_cooldown=false

func _on_skill_duration_timeout():
	honk.disabled=true
