class_name Move
extends State

@onready var player: Player = $"../.."

var direction : float

func physics_update(delta : float):
	direction = Input.get_axis("move_left", "move_right")
	if Input.is_action_just_pressed("jump"):
		transitioned.emit(self, "jump")
	if Input.is_action_just_pressed("attack"):
		transitioned.emit(self, "attack")
	if direction:
		change_direction_velocity(player, delta, direction)
	else: 
		transitioned.emit(self, "idle")
	if not player.is_on_floor():
		transitioned.emit(self, "fall")
	pass

func enter():
	if player.is_on_floor():
			player.animation_player.play("run")
	pass

func exit():
	player.animation_player.stop()
	pass
