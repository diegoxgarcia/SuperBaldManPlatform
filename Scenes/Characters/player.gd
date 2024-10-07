class_name Player
extends CharacterBody2D

@export var player_data : PlayerData

@onready var animation_player = $Visual/AnimationPlayer
@onready var state_machine = $StateMachine
@onready var visual = $Visual
@onready var weapon_handler = $Visual/WeaponHandler

signal update_match_data

func _ready():
	update_match_data.emit(player_data.health, player_data.score)
	pass

func _physics_process(delta):
	move_and_slide()

func _on_collecter_player_collected(area):
	area.queue_free()
	#score += 10 -> Actualiza el score (deberia llamar al game_manager?)
	#update_score.emit(score)
	pass


func _on_damager_player_damaged(body):
	player_data.health = player_data.health - body.enemy_data.power_attack
	state_machine.current_state.transitioned.emit(state_machine.current_state, "hurt")
	update_match_data.emit(player_data.health, player_data.score)
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
