extends Resource
class_name CharType

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
