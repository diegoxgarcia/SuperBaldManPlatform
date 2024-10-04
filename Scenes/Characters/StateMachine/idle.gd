class_name Idle
extends State

@onready var animation_player = $"../../Visual/AnimationPlayer"
@onready var player = $"../.."

func physics_update(delta : float):
	player.velocity = Vector2()
	
	pass
	
func update(delta : float):
	if Input.is_action_just_pressed("jump") and player.is_on_floor():
		transitioned.emit(self, "jump")
	if not player.is_on_floor():
		transitioned.emit(self, "fall")
	if Input.is_action_just_pressed("move_left") or Input.is_action_just_pressed("move_right"):
		transitioned.emit(self, "move")
	pass
	
func enter():
	animation_player.play("idle")
	pass

func exit():
	pass
