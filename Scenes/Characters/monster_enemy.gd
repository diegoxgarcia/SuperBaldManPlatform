class_name MonsterEnemy
extends CharacterBody2D

var SPEED = 100.0
const JUMP_VELOCITY = -400.0
@onready var animated_sprite_2d = $AnimatedSprite2D

var player : Player

func _physics_process(delta):
	fall(delta)
	direction_flip()
	follow_player()
	move_and_slide()
	
func fall(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta
		
func direction_flip():
	if velocity.x > 0:
		animated_sprite_2d.flip_h = true
	else:
		animated_sprite_2d.flip_h = false
		
func follow_player():
	if player != null:
		velocity = Vector2(player.global_position.x - global_position.x, player.global_position.y).normalized() * SPEED

func _on_proximity_detector_player_entered(body : CharacterBody2D):
	if body is Player:
		player = body
	pass
