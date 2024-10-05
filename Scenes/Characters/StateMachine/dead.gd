class_name Dead
extends State

@onready var player = $"../.."

func physics_update(delta : float):
	
	pass
	
func update(delta : float):
	pass
	
func enter():
	player.animation_player.play("dead")
	player.set_physics_process(false)
	pass

func exit():
	player.animation_player.stop()
	pass
