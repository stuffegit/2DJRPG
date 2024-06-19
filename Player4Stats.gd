extends Node

var PlayerName: String = "Hexxer"
var PlayerLevel: int = 1
var PlayerExp: int = 1
var PlayerExpToNext: int = 1
var PlayerExpTotal: int = 1
var PlayerStrength: int = 10
var PlayerAgility: int = 10
var PlayerVitality: int = 10
var PlayerSpirit: int = 10

# TODO: Fix inventory and equip system
var PlayerWeaponDamage: int = 5

var PlayerAttack: int = PlayerStrength + PlayerWeaponDamage

var PlayerDamage = PlayerAttack + ((PlayerAttack + PlayerLevel) / 32) * ((PlayerAttack * PlayerLevel) / 32)
