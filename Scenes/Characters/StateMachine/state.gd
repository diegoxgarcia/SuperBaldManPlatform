class_name State
extends Node

signal transitioned

func physics_update(delta : float):
	pass
	
func update(delta : float):
	pass
	
func enter():
	pass

func exit():
	pass

func change_direction_velocity(player : Player, delta : float, direction : float):
	player.velocity.x = direction * player.player_data.speed * delta
	if direction > 0:
		player.visual.scale.x = -1
	else:
		player.visual.scale.x = 1
	pass
