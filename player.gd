extends CharacterBody2D

const SPEED = 300.0

# Baseline Character Stats
@export var Name: String = "Unnamed"
@export var Icon: Texture2D = null
@export var Level: int = 1
@export var MaxHP: float = 0
@export var HP: float = 0
@export var Armor: int = 0
@export var Attack = 0
@export var Damage: int = 0
var InBattle: bool = false

# Player specific
@export var Exp: int = 0
@export var ExpToNext: int = 0
@export var ExpTotal: int = 0

# Job specific
@export var HPGain: float = 0
@export var Strength: float = 0
@export var StrengthGain: float = 0
@export var Agility: float = 0
@export var AgilityGain: float = 0
@export var Vitality: float = 0
@export var VitalityGain: float = 0
@export var Spirit: float = 0
@export var SpiritGain: float = 0

@export var chartype : CharType

@onready var _focus = $focus
@onready var progress_bar = $ProgressBar
@onready var floating_numbers = $TextPopupLocation
@onready var damage_numbers = %Label

@onready var player = self


 
var playerhealth: float:
	set(value):
		playerhealth = value
		floating_numbers.popup()
		
var enemyhealth: float:
	set(value):
		enemyhealth = value
		floating_numbers.popup()

func initialize_job_stats():
	HP = chartype.HP
	Name = chartype.Name
	Level = chartype.Level
	MaxHP = chartype.MaxHP
	HP = chartype.HP
	Armor = chartype.Armor
	Attack = chartype.Attack

	# Job specific
	HPGain = chartype.HPGain
	Strength = chartype.Strength
	StrengthGain = chartype.StrengthGain
	Agility = chartype.Agility
	AgilityGain = chartype.AgilityGain
	Vitality = chartype.Vitality
	VitalityGain = chartype.VitalityGain
	Spirit = chartype.Spirit
	SpiritGain = chartype.SpiritGain
 
func _ready():
	_update_progress_bar_players()

func _update_progress_bar_players():
	$HPLabel.text = str(HP)
	$ProgressBar.max_value = int(MaxHP)
	$ProgressBar.value = int(HP)

 
func focus():
	_focus.show()
 
func unfocus():
	_focus.hide()
 
func take_damage(value):
	print(str(HP))
	HP -= value
	progress_bar.value = int(HP)
	print(str(HP))
	playerhealth -= value
	damage_numbers.text = str(value)

	print("target is player")
	print("health of player: "+str(playerhealth))
	print("damage value: "+str(value))
		
	_update_progress_bar_players()

func update_sprite_facing():
	var input_dir = Vector2.ZERO
	input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = Vector2(input_dir.x,input_dir.y)
	if direction.x > 0.5 and direction.y > 0.5:
		if $Sprite2D.frame != 2:
			$Sprite2D.frame = 2 # DownRight
	elif direction.x < 0 and direction.y > 0.5:
		if $Sprite2D.frame != 3:
			$Sprite2D.frame = 3 # DownLeft
	elif direction.x > 0.5 and direction.y < 0:
		if $Sprite2D.frame != 2:
			$Sprite2D.frame = 2  # UpRight
	elif direction.x < 0 and direction.y < 0:
		if $Sprite2D.frame != 3:
			$Sprite2D.frame = 3 # UpLeft
	elif direction.x > 0.5:
		if $Sprite2D.frame != 2:
			$Sprite2D.frame = 2 # Right
	elif direction.x < 0:
		if $Sprite2D.frame != 3:
			$Sprite2D.frame = 3 # Left
	elif direction.y > 0.5:
		if $Sprite2D.frame != 0:
			$Sprite2D.frame = 0 # Up
	elif direction.y < 0:
		if $Sprite2D.frame != 1:
			$Sprite2D.frame = 1 # Down

func _physics_process(_delta):
	var input_dir = Vector2.ZERO
	input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = Vector2(input_dir.x, input_dir.y)
	if direction:
		velocity.x = direction.x * SPEED
		velocity.y = direction.y * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)
	if InBattle == false:
		update_sprite_facing()
		move_and_slide()
