extends Node2D

var go_go_baloons = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.y = position.y-go_go_baloons*delta

func go_balooons_go():
	go_go_baloons = 10+ 10 + 60
