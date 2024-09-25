extends Area2D

signal player_entered

func _on_body_entered(body : CharacterBody2D):
	player_entered.emit(body)
	pass
