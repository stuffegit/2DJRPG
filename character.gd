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


@export var MAX_HEALTH: float = Player1Stats.PlayerMaxHP
 
var health: float = Player1Stats.PlayerHP:
	set(value):
		health = value
		var health_string = "health: {health}"
		var health_print = health_string.format({"health": health})
		print(health_print)
		var value_string = "value: {value}"
		var value_print = value_string.format({"value": value})
		print(value_print)
		_update_progress_bar()
		_play_animation()
		floating_numbers.popup()
 
func _update_progress_bar():
	progress_bar.value = (Player1Stats.PlayerHP/Player1Stats.PlayerMaxHP) * 100
 
func _play_animation():
	animation_player.play("hurt")
 
func focus():
	_focus.show()
 
func unfocus():
	_focus.hide()
 
func take_damage(value, target):
	health -= value
	var health_string = "func health: {health}"
	var health_print = health_string.format({"health": health})
	print(health_print)
	var value_string = "func value: {value}"
	var value_print = value_string.format({"value": value})
	print(value_print)
	var target_string = "func target: {target}"
	var target_print = target_string.format({"target": target})
	print(target_print)
	players[target].PlayerHP -= value
	damage_numbers.text = str(value)
