extends Node
class_name State

@export var animation_name: String
var parent : SadMan

func enter(player_ref):
	parent.animations.play(animation_name)
	
func exit():
	pass
	
func process_physics(delta):
	return null
