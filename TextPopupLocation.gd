extends Marker2D
 
@onready var damage = $Label
@onready var reset_damage_pos = damage.position
@onready var animation_player = %AnimationPlayer

func _ready():
	randomize()

func popup():
	damage.position = reset_damage_pos
	animation_player.play("dmg_popup")

	var tween = get_tree().create_tween()
	tween.tween_property(damage,
						 "position",
						 damage.position + _get_direction(),
						 0.75)
 
func _get_direction():
	return Vector2(randf_range(-1,1), -randf()) * 16
 
func _input(event):
	if event.is_action_pressed("test"):
		popup()
