extends Button

var game_scene = load("res://scenes/game.tscn")


func start_game():
	#get_tree().change_scene_to_file("res://scenes/game.tscn")
	get_tree().change_scene_to_packed(game_scene)
	
func exit_game():
	get_tree().quit()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	#game_scene = preload("res://scenes/game.tscn")
	#var new_scene = game_scene.instantiate()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
