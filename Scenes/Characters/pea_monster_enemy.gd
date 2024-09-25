class_name PeaMonsterEnemy
extends CharacterBody2D

const SPEED = 200.0
const JUMP_VELOCITY = -400.0

@onready var animated_sprite_2d = $AnimatedSprite2D

#var direction = 0

var player : Player

func _physics_process(delta):
	fall(delta)
	follow_player()
	direction_flip()
	move_and_slide()
	
func _process(delta):
	pass	

func fall(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta
		
func direction_flip():
	if velocity.x > 0:
		animated_sprite_2d.flip_h = true
	elif velocity.x < 0:
		animated_sprite_2d.flip_h = false

		
func follow_player():
	if player != null:
		animated_sprite_2d.play("walk")
		velocity = Vector2(player.global_position.x - global_position.x, player.global_position.y).normalized() * SPEED
		#var directionPlayer = global_position.direction_to(player.global_position)
		#if directionPlayer.x < 0:
			#direction = -1
			#animated_sprite_2d.flip_h = false
		#elif directionPlayer.x > 0:
			#direction = 1
			#animated_sprite_2d.flip_h = true
		#else:
			#direction = 0

func _on_proximity_detector_player_entered(body : CharacterBody2D):
	if body is Player:
		player = body
	pass
