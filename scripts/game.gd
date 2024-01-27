extends Node2D

var SadManList = []
var GlobalHappinessLevel=0
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
	GlobalHappinessLevel=HappinessTotal
	var skillsAvailable=2
	if GlobalHappinessLevel>20:
		skillsAvailable+=1
	if GlobalHappinessLevel>40:
		skillsAvailable+=1
	if GlobalHappinessLevel>60:
		skillsAvailable+=1
	if GlobalHappinessLevel>80:
		skillsAvailable+=1
	$Player.skillsAvailable=skillsAvailable
		
		
func ultimateJoke():
	pass



func _on_player_skill_changed():
	$CanvasLayer/SkillText.text=$Player.skillNames[$Player.activeSkill-1]
	#$CanvasLayer/SkillText.text=""
