class_name Idle
extends State

@onready var player = $"../.."
@onready var animation_player = $"../../Visual/AnimationPlayer"

func update(delta : float):
	if Input.is_action_just_pressed("jump") && player.is_on_floor():
		transitioned.emit(self, "jump")
	if not player.is_on_floor():
		transitioned.emit(self, "fall")
	if  Input.get_axis("move_left", "move_right"):
		transitioned.emit(self, "move")
	if Input.is_action_just_pressed("attack"):
		transitioned.emit(self, "attack")
	pass
	
func enter():
	player.velocity.x = move_toward(player.velocity.x, 0, player.player_data.speed)
	animation_player.play("idle")
	pass

func exit():
	animation_player.stop()
	pass
