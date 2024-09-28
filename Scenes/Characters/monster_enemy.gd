class_name MonsterEnemy
extends CharacterBody2D

@export var enemy_data : EnemyData

@onready var animated_sprite_2d = $Visual/AnimatedSprite2D
@onready var visual = $Visual
@onready var proximity_player_detector = $Visual/ProximityPlayerDetector
@onready var animation_player = $Visual/AnimationPlayer
@onready var health_bar = $Control/HealthBar
var player : Player

func _ready():
	$Visual/Damager.enemy_damaged.connect(_on_damager_enemy_damaged)
	proximity_player_detector.set_target_position(enemy_data.target_position)
	health_bar.value = enemy_data.health
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
		velocity = Vector2(player.global_position.x - global_position.x, player.global_position.y).normalized() * enemy_data.speed
		if !animated_sprite_2d.is_playing():
			animated_sprite_2d.play("walkidle")

func enemy_damaged(anim_forward : String, anim_backward : String, area : Area2D):
	enemy_data.health = enemy_data.health - (area.weapon_data.damage * enemy_data.damage_multiplier)
	health_bar.value = enemy_data.health
	
	if enemy_data.health <= 0:
		dead()
		
	if visual.scale.x == -1:
		animation_player.play(anim_backward)
	elif visual.scale.x == 1:
		animation_player.play(anim_forward)
	pass

func dead():
	queue_free()
	pass

func _on_damager_enemy_damaged(area):
	animated_sprite_2d.play("hit")
	enemy_damaged("hit_back", "hit_back_backwards", area)
	pass
