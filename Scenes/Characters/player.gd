class_name Player
extends CharacterBody2D

@export var player_data : PlayerData

@onready var animation_player = $Visual/AnimationPlayer
@onready var state_machine = $StateMachine
@onready var visual = $Visual
@onready var weapon_handler = $Visual/WeaponHandler
@onready var sfx = $SFX

signal go_to_next_level
signal update_match_data
signal update_match_score_data
signal portal_opened_shake_cam

func _ready():
	update_match_data.emit(player_data.health, player_data.score)
	pass

func _physics_process(delta):
	move_and_slide()
	pass

func _on_collecter_player_collected(area):
	if area.is_in_group("Collectibles"):
		player_data.score = player_data.score + 1
		update_match_score_data.emit()
		sfx.get_node("VinylScratch").play()
		area.queue_free()
	elif area.is_in_group("Weapons"):
		area.queue_free()
	elif area.is_in_group("Checkpoints"):
		go_to_next_level.emit()
	pass


func _on_damager_player_damaged(body):
	player_data.health = player_data.health - body.enemy_data.power_attack
	state_machine.current_state.transitioned.emit(state_machine.current_state, "hurt")
	update_match_data.emit(player_data.health)
	pass


func _on_animation_player_animation_finished(anim_name):
	match anim_name:
		"hurt":
			if player_data.health > 0:
				state_machine.current_state.transitioned.emit(state_machine.current_state, "idle")
			else:
				state_machine.current_state.transitioned.emit(state_machine.current_state, "dead")
		"attack":
			state_machine.current_state.transitioned.emit(state_machine.current_state, "idle")
	pass
