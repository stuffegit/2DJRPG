extends Node

var PlayerName: String = "Hexxer"
var PlayerLevel: int = 1
var PlayerExp: int = 0
var PlayerExpToNext: int = 100
var PlayerExpTotal: int = 0
var PlayerHP: int = 100
var PlayerMaxHP: int = PlayerHP
var PlayerHPGain: int = 10
var PlayerStrength: int = 4
var PlayerStrengthGain = 4
var PlayerAgility: int = 2
var PlayerAgilityGain = 2
var PlayerVitality: int = 3
var PlayerVitalityGain = 3
var PlayerSpirit: int = 1
var PlayerSpiritGain = 1

# TODO: Fix inventory and equip system
var PlayerWeaponDamage: int = 5

var PlayerAttack: int = PlayerStrength + PlayerWeaponDamage

var PlayerDamage = PlayerAttack + ((PlayerAttack + PlayerLevel) / 32) * ((PlayerAttack * PlayerLevel) / 32)
