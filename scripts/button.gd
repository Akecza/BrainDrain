extends Button

@export var input : String

func _input(event):
	if (event.is_action_pressed(input)):
		emit_signal("pressed")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass