extends Node2D

var SadManList = []
var GlobalHappinessLevel=0
@onready var honk = $HonkPlayer
@onready var track1 : AudioStreamPlayer = $Music/TrackLevel1
@onready var track2 : AudioStreamPlayer = $Music/TrackLevel2
@onready var track3 : AudioStreamPlayer = $Music/TrackLevel3
@onready var trackFart : AudioStreamPlayer = $Music/TrackFart

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
	$CanvasLayer/HappinessContainer/VBoxContainer/GlobalHappinessBar.value=HappinessTotal
	GlobalHappinessLevel=HappinessTotal
	var skillsAvailable=2
	if GlobalHappinessLevel>10:
		track2.volume_db=0
		skillsAvailable+=1
	if GlobalHappinessLevel>20:
		trackFart.volume_db=0
		skillsAvailable+=1
	if GlobalHappinessLevel>30:
		track3.volume_db=0
		skillsAvailable+=1
	if GlobalHappinessLevel>70:
		skillsAvailable+=1
	if GlobalHappinessLevel>98:
		showVictoryScreen()
	$Player.skillsAvailable=skillsAvailable
		
		
func ultimateJoke():
	for i in SadManList:
		i.HappyBaloonBonus=20
		$Baloons.visible=true
		$Baloons.go_balooons_go()


func _on_player_skill_changed():
	$CanvasLayer/SkillText.text=$Player.skillNames[$Player.activeSkill-1]
	#$CanvasLayer/SkillText.text=""


func win():
	ultimateJoke()
	
func showVictoryScreen():
	pass
