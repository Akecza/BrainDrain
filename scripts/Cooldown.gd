extends TextureProgressBar

@export var player : RigidBody2D
@export var timerName : String
var timer : Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	timer = player.get_node(timerName)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	value=timer.time_left/timer.wait_time * 100
