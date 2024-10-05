class_name Fall
extends State

@onready var player = $"../.."

var direction

func physics_update(delta : float):
	direction = Input.get_axis("move_left", "move_right")
	if not player.is_on_floor():
		player.velocity += player.get_gravity() * delta
		if direction:
			change_direction_velocity(player, delta, direction)
	else:
		transitioned.emit(self, "idle")
	pass
	
func enter():
	player.animation_player.play("fall")
	pass

func exit():
	player.animation_player.stop()
	pass
