class_name Player
extends CharacterBody2D

@onready var animated_sprite_2d = $AnimatedSprite2D
const SPEED = 400.0
const JUMP_VELOCITY = -400.0
signal move


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		animated_sprite_2d.play("jump")

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		animated_sprite_2d.play("run")
		move.emit(direction)
		if direction > 0:
			animated_sprite_2d.flip_h = true
		else:
			animated_sprite_2d.flip_h = false
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		animated_sprite_2d.play("idle")
	move_and_slide()

func _on_collecter_player_collected(area):
	area.queue_free()
	#score += 10 -> Actualiza el score (deberia llamar al game_manager?)
	#update_score.emit(score)
	pass
