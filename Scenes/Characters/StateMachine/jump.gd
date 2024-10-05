class_name Jump
extends State

@onready var player: Player = $"../.."

var direction

func physics_update(delta : float):
	direction = Input.get_axis("move_left", "move_right")
	if not player.is_on_floor():
		player.velocity += player.get_gravity() * delta
		if direction:
			change_direction_velocity(player, delta, direction)
	else:
		transitioned.emit(self, "idle")
	if player.velocity.y > 0:
		transitioned.emit(self, "fall")
	pass
	
func enter():
	player.velocity.y = player.player_data.jump_velocity
	player.animation_player.play("jump")
	pass

func exit():
	player.animation_player.stop()
	pass
