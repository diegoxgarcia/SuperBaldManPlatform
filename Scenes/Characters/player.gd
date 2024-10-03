class_name Player
extends CharacterBody2D

@export var player_data : PlayerData

@onready var animation_player = $Visual/AnimationPlayer
@onready var sprite_2d = $Visual/Sprite2D
@onready var weapon_handler = $Visual/WeaponHandler
@onready var visual = $Visual

var direction

var mic_scene = preload("res://Scenes/Weapons/mic_weapon.tscn")
var new_mic : Mic

signal move

func _ready():
	new_mic = mic_scene.instantiate()
	pass

func _physics_process(delta):
	fall(delta)
	check_jump()
	check_attack()
	check_idle()
	check_move_x()
	move_and_slide()
	
func fall(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta
	if velocity.y > 0:
		animation_player.play("fall")
	pass
		
func check_jump():
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = player_data.jump_velocity
		animation_player.play("jump")
	pass
	
func check_attack():
	if Input.is_action_just_pressed("attack"):
		animation_player.play("attack")
		if weapon_handler.get_child_count() == 0:
			weapon_handler.add_child(new_mic)
	pass
	
func check_idle():
	if not animation_player.is_playing():
		animation_player.play("idle")
		if weapon_handler.get_child_count() > 0:
			weapon_handler.remove_child(weapon_handler.get_child(0))
	pass

func check_move_x():
	direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * player_data.speed
		if is_on_floor():
			animation_player.play("run")
		move.emit(direction)
		if direction > 0:
			visual.scale.x = -1
		else:
			visual.scale.x = 1
	else: 
		velocity.x = move_toward(velocity.x, 0, player_data.speed)
	pass

func _on_collecter_player_collected(area):
	area.queue_free()
	#score += 10 -> Actualiza el score (deberia llamar al game_manager?)
	#update_score.emit(score)
	pass


func _on_damager_player_damaged(body):
	animation_player.play("hurt")
	Input.start_joy_vibration(0, 0.5, 0.5, 0.3)
	print_debug("Enemigo daña: " + str(body))
	pass


func _on_animation_player_animation_finished(anim_name):
	if animation_player == "dead":
		#set_physics_process(false)
		pass # Replace with function body.
