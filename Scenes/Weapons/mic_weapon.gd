class_name Mic
extends Area2D

signal enemy_hitted(int)
const damage : int = 10
@onready var animation_player = $AnimationPlayer


func play_attack_right():
	animation_player.play("attack_right")
	
func play_attack_left():
	animation_player.play("attack")

func _on_area_entered(area):
	
	pass # Replace with function body.
