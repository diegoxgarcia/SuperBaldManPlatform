extends Node2D
@onready var player = $Player
@onready var portal = $Portal
var flag = false

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		_back_to_main_menu()
	if player.player_data.score == 1 && !flag:
		portal.open_portal()
		flag = true

func _back_to_main_menu():
	get_tree().change_scene_to_file("res://Scenes/Menu/main_menu.tscn")
	pass
