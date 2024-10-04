class_name Fall
extends State

@onready var animation_player = $"../../Visual/AnimationPlayer"
@onready var player = $"../.."

func physics_update(delta : float):
	if not player.is_on_floor():
		player.velocity += player.get_gravity() * delta
	else:
		transitioned.emit(self, "idle")
	pass
	
func update(delta : float):

	pass
	
func enter():
	animation_player.play("fall")
	pass

func exit():
	pass
