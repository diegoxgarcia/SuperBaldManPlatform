class_name Move
extends State

@onready var player: Player = $"../.."
@onready var animation_player: AnimationPlayer = $"../../Visual/AnimationPlayer"

var direction

func physics_update(delta : float):
	direction = Input.get_axis("move_left", "move_right")
	if direction:
		player.velocity.x = direction * player.player_data.speed * delta
		animation_player.play("run")
		#if player.is_on_floor():
			#animation_player.play("run")
		if direction > 0:
			player.visual.scale.x = -1
		else:
			player.visual.scale.x = 1
		if player.velocity.y > 0:
			transitioned.emit(self, "fall")
	else: 
		transitioned.emit(self, "idle")
		#player.velocity.x = move_toward(player.velocity.x, 0, player.player_data.speed)
	pass
	
func update(delta : float):
	pass
	
func enter():
	if player.is_on_floor():
			animation_player.play("run")
	pass

func exit():
	animation_player.stop()
	pass
