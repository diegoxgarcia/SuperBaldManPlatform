class_name Dead
extends State

@onready var player = $"../.."

func enter():
	player.animation_player.play("dead")
	player.set_physics_process(false)
	pass

func exit():
	player.animation_player.stop()
	pass
