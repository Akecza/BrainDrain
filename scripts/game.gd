extends Node2D

var SadManList = []
@onready var honk = $HonkPlayer2D
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	countGlobalHappiness()
	

func _on_honk_pressed():
	honk.play()
	
func countGlobalHappiness():
	var HappinessTotal=0
	for i in SadManList:
		HappinessTotal += i.getHappinessValue()
	HappinessTotal=HappinessTotal/SadManList.size()
	$CanvasLayer/GlobalHappinessBar.value=HappinessTotal

