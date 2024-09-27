class_name MonsterEnemy
extends CharacterBody2D

@export var enemy_data : EnemyData

@onready var animated_sprite_2d = $Visual/AnimatedSprite2D
@onready var visual = $Visual
@onready var proximity_player_detector = $Visual/ProximityPlayerDetector
@onready var animation_player = $Visual/AnimationPlayer

var player : Player

func _ready():
	proximity_player_detector.set_target_position(enemy_data.target_position)
	pass

func _physics_process(delta):
	fall(delta)
	direction_flip()
	follow_player()
	move_and_slide()
	
func _process(delta):
	player = proximity_player_detector.check_player_collide()
	pass
	
func fall(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta
		
func direction_flip():
	if velocity.x > 0:
		visual.scale.x = -1
	elif velocity.x < 0:
		visual.scale.x = 1
		
func follow_player():
	if player != null:
		animated_sprite_2d.play("walkidle") #Este animation sprite debe coincidir en todos los enemigos
		velocity = Vector2(player.global_position.x - global_position.x, player.global_position.y).normalized() * enemy_data.speed

func _on_damager_enemy_damaged():
	print_debug("Enemigo golpeado")
	pass # Replace with function body.
