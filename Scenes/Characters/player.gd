class_name Player
extends CharacterBody2D

@onready var animation_player = $AnimationPlayer
@onready var sprite_2d = $Sprite2D
@onready var weapon_handler_left = $WeaponHandlerLeft
@onready var weapon_handler_right = $WeaponHandlerRight
var direction

var mic_scene = preload("res://Scenes/Weapons/mic_weapon.tscn")
var new_mic
var animation_flip = false

const SPEED = 400.0
const JUMP_VELOCITY = -500.0
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
		print_debug(velocity)
	if velocity.y > 0:
		animation_player.play("fall")
	pass
		
func check_jump():
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		animation_player.play("jump")
	pass
	
func check_attack():
	if Input.is_action_just_pressed("attack"):
		animation_player.play("attack")
		if animation_flip:
			weapon_handler_right.add_child(new_mic)
			if weapon_handler_right.get_child(0):
				weapon_handler_right.get_child(0).play_attack_right()
		else:
			weapon_handler_left.add_child(new_mic)
			if weapon_handler_left.get_child(0):
				weapon_handler_left.get_child(0).play_attack_left()
		
	pass
	
func check_idle():
	if not animation_player.is_playing():
		animation_player.play("idle")
		weapon_handler_left.remove_child(weapon_handler_left.get_child(0))
		weapon_handler_right.remove_child(weapon_handler_right.get_child(0))
	pass

func check_move_x():
	direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		if is_on_floor():
			animation_player.play("run")
		move.emit(direction)
		if direction > 0:
			animation_flip = true
			sprite_2d.flip_h = true
		else:
			animation_flip = false
			sprite_2d.flip_h = false
	else: 
		velocity.x = move_toward(velocity.x, 0, SPEED)
	pass


func _on_collecter_player_collected(area):
	area.queue_free()
	#score += 10 -> Actualiza el score (deberia llamar al game_manager?)
	#update_score.emit(score)
	pass


func _on_damager_player_damaged():
	pass # Replace with function body.
