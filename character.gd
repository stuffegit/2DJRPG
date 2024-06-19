extends CharacterBody2D
 
@onready var _focus = $focus
@onready var progress_bar = $ProgressBar
@onready var animation_player = $AnimationPlayer
@onready var floating_numbers = $TextPopupLocation
@onready var damage_numbers = %Label
var players = [
		Player1Stats,
		Player2Stats,
		Player3Stats,
		Player4Stats
	]
var EnemyStats = [
		Enemy1Stats,
		Enemy2Stats,
		Enemy3Stats,
		Enemy4Stats
	]
 
var playerhealth: float = Player1Stats.PlayerHP:
	set(value):
		playerhealth = value
		_play_animation()
		floating_numbers.popup()
		
var enemyhealth: float = Enemy1Stats.EnemyHP:
	set(value):
		enemyhealth = value
		_play_animation()
		floating_numbers.popup()
 
func _ready():
	_update_progress_bar_players()
	_update_progress_bar_enemies()

func _update_progress_bar_players():
	for i in GlobalVars.PlayerAmount:
		var str_i: String = str(i+1)
		var playerprogbar = get_node("../../PlayerGroup/Character" + str_i + "/ProgressBar")
		playerprogbar.max_value = int(players[i].PlayerMaxHP)
		playerprogbar.value = int(players[i].PlayerHP)
			

func _update_progress_bar_enemies():
	var enemies = get_node("../../EnemyGroup").get_children()
	for i in enemies.size():
		var str_i: String = str(i+1)
		var enemyprogbar = get_node("../../EnemyGroup/Character" + str_i + "/ProgressBar")
		if enemyprogbar:
			enemyprogbar.max_value = int(EnemyStats[i].EnemyMaxHP)
			enemyprogbar.value = int(EnemyStats[i].EnemyHP)
 
func _play_animation():
	animation_player.play("hurt")
 
func focus():
	_focus.show()
 
func unfocus():
	_focus.hide()
 
func take_damage(value, target):
	if GlobalVars.PlayerTurn == false:
		print(players[target].PlayerHP)
		players[target].PlayerHP -= value
		get_node("../../PlayerGroup/Character" + str(target+1) + "/ProgressBar").value = int(players[target].PlayerHP)
		print(players[target].PlayerHP)
		playerhealth -= value
		damage_numbers.text = str(value)
		
		#var target_string = "target is player: {target}"
		#var target_print = target_string.format({"target": target})
		#print(target_print)
		#var health_string = "health of player: {health}"
		#var health_print = health_string.format({"health": playerhealth})
		#print(health_print)
		#var value_string = "damage value: {value}"
		#var value_print = value_string.format({"value": value})
		#print(value_print)
		
	if GlobalVars.PlayerTurn == true:
		EnemyStats[target].EnemyHP -= value
		enemyhealth -= value
		damage_numbers.text = str(value)
		
		#var target_string = "target is enemy: {target}"
		#var target_print = target_string.format({"target": target})
		#print(target_print)
		#var health_string = "health of enemy: {health}"
		#var health_print = health_string.format({"health": enemyhealth})
		#print(health_print)
		#var value_string = "damage value: {value}"
		#var value_print = value_string.format({"value": value})
		#print(value_print)
		
	_update_progress_bar_players()
	_update_progress_bar_enemies()
