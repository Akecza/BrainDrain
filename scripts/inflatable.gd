extends Node2D

@onready var timer : Timer = $DeathTimer
@onready var inflatableSound: CollisionShape2D = $InflatableSound/InflatableSoundCollision
@onready var audioStreamPlayer2D : AudioStreamPlayer2D = $AudioStreamPlayer2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_death_timer_timeout():
	queue_free()


