extends Node2D

var rng = RandomNumberGenerator.new()

enum BATTLE_STATES {
	PLAYER_TURN, 
	ENEMY_TURN, 
	WIN,
	LOSE
}

var enemies: Array = []
@onready var player = $Player

var current_state
var index: int = 0

var player_team = Array()
var player_turn_order = Array()

var enemy_team = Array()
var enemy_turn_order = Array()

var playerturn_damage
var enemyturn_damage
var playertarget
@onready var resetfocus = $Player/focus

@onready var choice = $"CanvasLayer/choice"

func _ready():
	player.initialize_job_stats()
	player._update_progress_bar_players()
	player.InBattle = true
	randomize()
	enemies = $EnemyGroup.get_children()
	print("enemies variable: " +str(enemies))
	for i in enemies.size():
		enemies[i].position = Vector2(i*-64, i*128)
		enemies[i].initialize_monster_stats()
		enemies[i]._update_progress_bar_enemies()
	_handle_states(BATTLE_STATES.PLAYER_TURN)
	
	for i in range(0, 2):
		player_team.push_back(enemies[i])
		
func _handle_states(new_state):
	current_state = new_state
	await get_tree().create_timer(0.3).timeout
	
	match current_state:
		BATTLE_STATES.PLAYER_TURN:
			%GameStateLabel.text = "PLAYER_TURN"
			print("player turn start")
			show_choice()
		BATTLE_STATES.ENEMY_TURN:
			hide_choice()
			enemy_turn_order = enemy_team
			%GameStateLabel.text = "ENEMY_TURN"
			print("enemy turn start")
			await get_tree().create_timer(0.1).timeout # enemy_turn_order is 0 without this

			_handle_enemy_turn()
		BATTLE_STATES.WIN:
			%GameStateLabel.text = "WIN"
		BATTLE_STATES.LOSE:
			%GameStateLabel.text = "LOSE"

func _handle_enemy_turn():
	print("handle enemy turn")
	if enemy_turn_order.size() < 0:
		show_choice()
		_handle_states(BATTLE_STATES.PLAYER_TURN)
		
	else:
		for i in range(enemies.size()):
			print("enemy turn order: "+str(i+1))
			enemies[i].Damage = int(rng.randf_range(enemies[i].Attack*0.8, enemies[i].Attack*1.2))
			$Player.take_damage(enemies[i].Damage)
			await get_tree().create_timer(1).timeout
			enemy_turn_order.pop_front()
		_handle_states(BATTLE_STATES.PLAYER_TURN)


func _attack_command(target):
	$Player/focus.hide()
	player.Damage = int(rng.randf_range(player.Attack*0.8, player.Attack*1.2))
	enemies[target].take_damage(player.Damage, target)
	await get_tree().create_timer(1).timeout
	_handle_states(BATTLE_STATES.ENEMY_TURN)

func _process(_delta):
	if not choice.visible:
		if Input.is_action_just_pressed("ui_up"):
			if index > 0:
				index -= 1
				switch_focus(index, index+1)
				
		if Input.is_action_just_pressed("ui_down"):
			if index < enemies.size() - 1:
				index += 1
				switch_focus(index, index - 1)

		if Input.is_action_just_pressed("ui_accept"):
			_action(index)
			_reset_focus()

func _action(index):
	_attack_command(index)

func switch_focus(x,y):
	for enemy in enemies:
		enemy.unfocus()
	enemies[x].focus()
	#print("enemy"+str(enemies[x])+"focused in switch_focus func")
	enemies[y].unfocus()
	#print("enemy"+str(enemies[x])+"unfocused in switch_focus func")

func show_choice():
	choice.show()
	choice.find_child("Attack").grab_focus()

func hide_choice():
	choice.hide()

func _reset_focus():
	index = 0
	for enemy in enemies:
		enemy.unfocus()
		#print("enemy"+str(enemy)+"focused in _reset_focus func")

func _start_choosing():
	#print("start choosing")
	_reset_focus()
	enemies[0].focus()
	#print("enemy"+str(enemies)[0]+"focused in _start_choosing func")


func _on_attack_pressed():
	#print("on attack pressed")
	choice.hide()
	_start_choosing()
