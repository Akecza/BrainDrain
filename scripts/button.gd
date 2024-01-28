extends Button

@export var input : String
@export var player : RigidBody2D

func _input(event):
	if (event.is_action_pressed(input) && !disabled):
		emit_signal("pressed")
		
func change_skill():
	player.changeSkill(int(input))


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
