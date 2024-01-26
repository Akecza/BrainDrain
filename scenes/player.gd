extends RigidBody2D
@export var speed = 400 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.
var skill_on_cooldown = false



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

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	linear_velocity=velocity

func skill_honk():
	if(not skill_on_cooldown):
		skill_on_cooldown=true
		$SkillCooldown.start()
		$SkillRange.disabled=false
		$SkillDuration.start()

func _on_skill_cooldown_timeout():
	skill_on_cooldown=false


func _on_skill_duration_timeout():
	$SkillRange.disabled=false
