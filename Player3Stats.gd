extends Node

var PlayerName: String = "Cleric"
var PlayerLevel: int = 1
var PlayerExp: int = 0
var PlayerExpToNext: int = 100
var PlayerExpTotal: int = 0
var PlayerHP: float = 70
var PlayerMaxHP: float = PlayerHP
var PlayerHPGain: float = 10
var PlayerStrength: float = 4
var PlayerStrengthGain: float = 4
var PlayerAgility: float = 2
var PlayerAgilityGain: float = 2
var PlayerVitality: float = 3
var PlayerVitalityGain: float = 3
var PlayerSpirit: float = 1
var PlayerSpiritGain: float = 1

# TODO: Fix inventory and equip system
var PlayerWeaponDamage: int = 5

var PlayerAttack: float = PlayerStrength + PlayerWeaponDamage

var PlayerDamage = PlayerAttack + ((PlayerAttack + PlayerLevel) / 32) * ((PlayerAttack * PlayerLevel) / 32)
