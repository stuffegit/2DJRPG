extends Node2D

var rng = RandomNumberGenerator.new()
var enemies: Array = []
var action_queue: Array = []
var is_battling: bool = false
var index: int = 0
var player_damages = [
		Player1Stats.PlayerDamage,
		Player2Stats.PlayerDamage,
		Player3Stats.PlayerDamage,
		Player4Stats.PlayerDamage
	]
var playerturn_damage

signal next_player
@onready var choice = $"../CanvasLayer/choice"

func _ready():
	randomize()
	enemies = get_children()
	for i in enemies.size():
		enemies[i].position = Vector2(i*-64, i*128)
		
	show_choice()
		
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
			action_queue.push_back(index)
			emit_signal("next_player")
			show_choice()
	
	if action_queue.size() == enemies.size() and not is_battling:
		is_battling = true
		_action(action_queue)
		_reset_focus()
		# Enemy Turn

func _action(stack):
	for i in stack:
		playerturn_damage = int(rng.randf_range(player_damages[i]*0.8, player_damages[i]*1.2))
		enemies[i].take_damage(playerturn_damage)
		await get_tree().create_timer(1).timeout
	action_queue.clear()
	is_battling = false
	show_choice()

func switch_focus(x,y):
	enemies[x].focus()
	enemies[y].unfocus()

func show_choice():
	choice.show()
	choice.find_child("Attack").grab_focus()

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
