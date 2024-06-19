extends CharacterBody2D

const SPEED = 300.0

var rng = RandomNumberGenerator.new()

func level_up():
	Player1Stats.PlayerStrengthGain = 4+0.3*(Player1Stats.PlayerLevel)
	Player1Stats.PlayerAgilityGain = 2+0.15*(Player1Stats.PlayerLevel)
	Player1Stats.PlayerVitalityGain = 3+0.3*(Player1Stats.PlayerLevel)
	Player1Stats.PlayerSpiritGain = 1+0.05*(Player1Stats.PlayerLevel)
	Player1Stats.PlayerHPGain = 10+0.5*(Player1Stats.PlayerLevel)
	#var str_string = "Strength: {strgain}"
	#var str_print = str_string.format({"strgain": Player1Stats.PlayerStrengthGain})
	#print(str_print)
	#var agi_string = "Agility : {agigain}"
	#var agi_print = agi_string.format({"agigain": Player1Stats.PlayerAgilityGain})
	#print(agi_print)
	#var vit_string = "Vitality: {vitgain}"
	#var vit_print = vit_string.format({"vitgain": Player1Stats.PlayerVitalityGain})
	#print(vit_print)
	#var spi_string = "Spirit  : {spigain}"
	#var spi_print = spi_string.format({"spigain": Player1Stats.PlayerSpiritGain})
	#print(spi_print)
	#var hp_string = "HP      : {hpgain}"
	#var hp_print = hp_string.format({"hpgain": Player1Stats.PlayerHPGain})
	#print(hp_print)
	Player1Stats.PlayerLevel += 1
	Player1Stats.PlayerStrength += int(rng.randf_range(Player1Stats.PlayerStrengthGain, Player1Stats.PlayerStrengthGain*1.5))
	Player1Stats.PlayerAgility += int(rng.randf_range(Player1Stats.PlayerAgilityGain, Player1Stats.PlayerAgilityGain*1.5))
	Player1Stats.PlayerVitality += int(rng.randf_range(Player1Stats.PlayerVitalityGain, Player1Stats.PlayerVitalityGain*1.5))
	Player1Stats.PlayerSpirit += int(rng.randf_range(Player1Stats.PlayerSpiritGain, Player1Stats.PlayerSpiritGain*1.5))
	Player1Stats.PlayerHP += int(rng.randf_range(Player1Stats.PlayerHPGain, Player1Stats.PlayerHPGain*1.5))
		
	update_stat_labels()

func gain_exp(value):
	Player1Stats.PlayerExp += value
	Player1Stats.PlayerExpTotal += value
	
	while Player1Stats.PlayerExp >= Player1Stats.PlayerExpToNext:
		Player1Stats.PlayerExp -= Player1Stats.PlayerExpToNext
		level_up()

func update_stat_labels():
	%Label.text = str(Player1Stats.PlayerLevel)
	%HP.text = str(Player1Stats.PlayerHP)
	%Strength.text = str(Player1Stats.PlayerStrength)
	%Vitality.text = str(Player1Stats.PlayerVitality)
	%Agility.text = str(Player1Stats.PlayerAgility)
	%Spirit.text = str(Player1Stats.PlayerSpirit)
	%ProgressBar.max_value = Player1Stats.PlayerExpToNext
	%ProgressBar.value = Player1Stats.PlayerExp

func _on_gain_exp_pressed():
	gain_exp(Player1Stats.PlayerExpToNext)
	update_stat_labels()

func _ready():
	update_stat_labels()

func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()



