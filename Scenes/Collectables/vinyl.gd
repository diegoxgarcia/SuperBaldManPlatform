class_name Vinyl
extends Area2D

@onready var animation_player = $AnimationPlayer

func _ready():
	animation_player.play("spin")
	pass
