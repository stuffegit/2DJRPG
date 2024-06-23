extends Node2D

@onready var Player = $Player
var rng = RandomNumberGenerator.new()

func _ready():
	randomize()
	#lvlupdebuglabel()

func _process(_delta):
	pass

func levelup():
	Player.StrengthGain = 4+0.3*(Player.Level)
	Player.AgilityGain = 2+0.15*(Player.Level)
	Player.VitalityGain = 3+0.3*(Player.Level)
	Player.SpiritGain = 1+0.05*(Player.Level)
	Player.HPGain = 10+0.5*(Player.Level)
	print("Strength: "+str(Player.StrengthGain))
	print("Agility : "+str(Player.AgilityGain))
	print("Vitality: "+str(Player.VitalityGain))
	print("Spirit  : "+str(Player.SpiritGain))
	print("HP      : "+str(Player.HPGain))
	Player.Level += 1
	Player.Strength += int(rng.randf_range(Player.StrengthGain, Player.StrengthGain*1.5))
	Player.Agility += int(rng.randf_range(Player.AgilityGain, Player.AgilityGain*1.5))
	Player.Vitality += int(rng.randf_range(Player.VitalityGain, Player.VitalityGain*1.5))
	Player.Spirit += int(rng.randf_range(Player.SpiritGain, Player.SpiritGain*1.5))
	Player.HP += int(rng.randf_range(Player.HPGain, Player.HPGain*1.5))
	#lvlupdebuglabel()

#func lvlupdebuglabel():
	#%Label.text = str(Player.Level)
	#%HP.text = str(Player.HP)
	#%Strength.text = str(Player.Strength)
	#%Vitality.text = str(Player.Vitality)
	#%Agility.text = str(Player.Agility)
	#%Spirit.text = str(Player.Spirit)


func _on_button_pressed():
	levelup()
