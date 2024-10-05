class_name Attack
extends State

@onready var player = $"../.."
	
func enter():
	player.animation_player.play("attack")
	if player.weapon_handler.get_child_count() == 0:
		player.weapon_handler.add_child(preload("res://Scenes/Weapons/mic_weapon.tscn").instantiate())
	pass

func exit():
	if player.weapon_handler.get_child_count() > 0:
			player.weapon_handler.remove_child(player.weapon_handler.get_child(0))
	player.animation_player.stop()
	pass
