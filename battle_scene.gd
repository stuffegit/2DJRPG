extends Node2D

var rng = RandomNumberGenerator.new()

enum BATTLE_STATES {
	PLAYER_TURN, 
	ENEMY_TURN, 
	WIN,
	LOSE
}


@onready var enemies = $EnemyGroup.get_children()
@onready var player = %Player

var current_state
var index: int = 0

var player_team = Array()
var enemy_turn_order = Array()

var playerturn_damage
var enemyturn_damage
var playertarget
var attacked = false
@onready var resetfocus = $Player/focus

@onready var choice = $"CanvasLayer/choice"

func _ready():
	%Player.initialize_job_stats()
	%Player._update_progress_bar_players()
	player.InBattle = true
	randomize()
	print("enemies variable: " +str(enemies))
	for i in enemies.size():
		enemies[i].position.y += i*128
		enemies[i].position.x -= i*64
		enemies[i].initialize_monster_stats()
		enemies[i]._update_progress_bar_enemies()
	_handle_states(BATTLE_STATES.PLAYER_TURN)

	
	for i in range(enemies.size()):
		player_team.push_back(enemies[i])

func _handle_states(new_state):
	current_state = new_state
	await get_tree().create_timer(0.1).timeout
	
	match current_state:
		BATTLE_STATES.PLAYER_TURN:
			enemies = $EnemyGroup.get_children()
			if player.HP > 0:
				if enemies.size() > 0:
					%GameStateLabel.text = "PLAYER_TURN"
					print("player turn start")
					show_choice()
					attacked = false
				else:
					hide_choice()
					_handle_states(BATTLE_STATES.WIN)
			else:
				hide_choice()
				_handle_states(BATTLE_STATES.LOSE)
		BATTLE_STATES.ENEMY_TURN:
			hide_choice()
			enemies = $EnemyGroup.get_children()
			enemy_turn_order = enemies
			%GameStateLabel.text = "ENEMY_TURN"
			print("enemy turn start")
			await get_tree().create_timer(0.1).timeout # enemy_turn_order is 0 without this

			_handle_enemy_turn()
		BATTLE_STATES.WIN:
			%GameStateLabel.text = "WIN"
			await get_tree().create_timer(2).timeout
			get_tree().change_scene_to_file("res://game.tscn")
			
		BATTLE_STATES.LOSE:
			%GameStateLabel.text = "LOSE"

func _handle_enemy_turn():
	print("handle enemy turn")
	while enemy_turn_order.size() > 0:
		print("enemy_turn_order 0: "+str(enemy_turn_order.front()))
		print("enemy turn order: "+str(enemy_turn_order.size()))
		enemy_turn_order.front().Damage = int(rng.randf_range(enemy_turn_order.front().Attack*0.8, enemy_turn_order.front().Attack*1.2))
		$Player.take_damage(enemy_turn_order.front().Damage)
		await get_tree().create_timer(1).timeout
		enemy_turn_order.pop_front()
	show_choice()
	_handle_states(BATTLE_STATES.PLAYER_TURN)

func _attack_command(target):
	attacked = true
	$Player/focus.hide()
	player.Damage = int(rng.randf_range(player.Attack*0.8, player.Attack*1.2))
	enemies[target].take_damage(player.Damage, target)
	await get_tree().create_timer(1).timeout
	if enemies[target].HP <= 0 or not enemies[target].HP:
		enemies[target].queue_free()
		if enemy_turn_order:
			enemy_turn_order.remove_at(target)
			await get_tree().create_timer(0.1).timeout
	if enemies.size() > 0:
		_handle_states(BATTLE_STATES.ENEMY_TURN)
	else: 
		_handle_states(BATTLE_STATES.WIN)

func _process(_delta):
	if not choice.visible and current_state == BATTLE_STATES.PLAYER_TURN and attacked == false:
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

func _action(actionindex):
	_attack_command(actionindex)

func switch_focus(x,y):
	for enemy in enemies:
		enemy.unfocus()
	enemies[x].focus()
	enemies[y].unfocus()

func show_choice():
	choice.show()
	choice.find_child("Attack").grab_focus()

func hide_choice():
	choice.hide()

func _reset_focus():
	index = 0
	for enemy in enemies:
		enemy.unfocus()

func _start_choosing():
	_reset_focus()
	enemies[0].focus()

func _on_attack_pressed():
	choice.hide()
	_start_choosing()
