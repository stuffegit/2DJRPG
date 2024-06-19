extends CharacterBody2D

@onready var _focus = $focus
@onready var progress_bar = $ProgressBar
@onready var animation_player = %AnimationPlayer
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
var enemies: Array = []
var defeated: int = 0
var enemyprogbar
var enemyhplabel
 
var playerhealth: float:
	set(value):
		playerhealth = value
		_play_animation()
		floating_numbers.popup()
		
var enemyhealth: float:
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
		var playerhplabel = get_node("../../PlayerGroup/Character" + str_i + "/HPLabel")
		playerhplabel.text = str(players[i].PlayerHP)
		playerprogbar.max_value = int(players[i].PlayerMaxHP)
		playerprogbar.value = int(players[i].PlayerHP)
			

func _update_progress_bar_enemies():
	_get_children_of_enemies()
	for i in enemies.size():
		var str_i: String = str(i+1)
		if get_node("../../EnemyGroup/Character" + str_i + "/HPLabel") != null:
			enemyhplabel = get_node("../../EnemyGroup/Character" + str_i + "/HPLabel")
			enemyhplabel.text = str(EnemyStats[i-defeated].EnemyHP)
		if get_node("../../EnemyGroup/Character" + str_i + "/ProgressBar") != null:
			enemyprogbar = get_node("../../EnemyGroup/Character" + str_i + "/ProgressBar")
			enemyprogbar.max_value = int(EnemyStats[i].EnemyMaxHP)
			enemyprogbar.value = int(EnemyStats[i].EnemyHP)
		# TODO: This is cursed, i'll do it later.
		#if EnemyStats[i].EnemyHP <= 0:
			#enemies[i].queue_free()
			#_get_children_of_enemies()

func _get_children_of_enemies():
	enemies = get_node("../../EnemyGroup").get_children()
 
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
