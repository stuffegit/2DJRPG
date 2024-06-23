extends CharacterBody2D



# Baseline Character Stats
@export var IsPlayer: bool = false
@export var Name: String = "Unnamed"
@export var Icon: Texture2D = null
@export var Level: int = 1
@export var MaxHP: float = 0
@export var HP: float = 0
@export var Armor: int = 0
@export var Attack = 0
@export var Damage: int = 0

@export var chartype : CharType

func initialize_monster_stats():
	HP = chartype.HP
	Name = chartype.Name
	Level = chartype.Level
	MaxHP = chartype.MaxHP
	HP = chartype.HP
	Armor = chartype.Armor
	Attack = chartype.Attack
	MaxHP = HP

@onready var _focus = $focus
@onready var progress_bar = $ProgressBar
@onready var animation_player = %AnimationPlayer
@onready var floating_numbers = $TextPopupLocation
@onready var damage_numbers = %Label
var enemies: Array = []
var enemyprogbar
var enemyhplabel
		
var enemyhealth: float:
	set(value):
		enemyhealth = value
		_play_animation()
		floating_numbers.popup()
		
 
func _ready():
	_update_progress_bar_enemies()

func _update_progress_bar_enemies():
	if $HPLabel != null:
		enemyhplabel = $HPLabel
		enemyhplabel.text = str(HP)
	if $ProgressBar != null:
		enemyprogbar = $ProgressBar
		enemyprogbar.max_value = MaxHP
		enemyprogbar.value = HP
 
func _play_animation():
	animation_player.play("hurt")
 
func focus():
	_focus.show()
 
func unfocus():
	_focus.hide()
 
func take_damage(value, target):
	HP -= value
	enemyhealth -= value
	damage_numbers.text = str(value)
	
	print("target is enemy: "+str(target))
	print("health of enemy: "+str(enemyhealth))
	print("damage value: "+str(value))
	
	_update_progress_bar_enemies()
