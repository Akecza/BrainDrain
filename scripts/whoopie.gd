extends Node2D

@onready var timer : Timer = $DeathTimer
@onready var fartCooldown : Timer = $FartCooldown
@onready var fartDuration : Timer = $FartDuration
@onready var whoopieSound: CollisionShape2D = $WhoopieSound/WhoopieSoundCollision
@onready var audioStreamPlayer2D : AudioStreamPlayer2D = $AudioStreamPlayer2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_death_timer_timeout():
	queue_free()

func _on_whoopie_area_entered(area : Area2D):
	if (area.get_parent().is_in_group("Sadman")):
		fart()

func fart():
	whoopieSound.set_deferred("disabled", false)
	audioStreamPlayer2D.play()
	fartCooldown.start()
	fartDuration.start()

func _on_fart_duration_timeout():
	whoopieSound.set_deferred("disabled", true)
