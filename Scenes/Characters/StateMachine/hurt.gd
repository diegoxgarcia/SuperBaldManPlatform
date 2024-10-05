class_name Hurt
extends State

@onready var player = $"../.."

func enter():
	player.animation_player.play("hurt")
	Input.start_joy_vibration(0, 0.5, 0.5, 0.3)
	pass

func exit():
	player.animation_player.stop()
	pass
