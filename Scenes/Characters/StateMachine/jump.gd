class_name Jump
extends State

@onready var animation_player: AnimationPlayer = $"../../Visual/AnimationPlayer"
@onready var player: Player = $"../.."

func physics_update(delta : float):
	if not player.is_on_floor():
		player.velocity += player.get_gravity() * delta
	else:
		transitioned.emit(self, "idle")
	pass
	
func update(delta : float):
	pass
	
func enter():
	player.velocity.y = player.player_data.jump_velocity
	animation_player.play("jump")
	pass

func exit():
	pass
