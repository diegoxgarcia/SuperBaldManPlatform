extends Control

@onready var animation_player = $AnimationPlayer

func _ready():
	animation_player.play("title_anim")
	pass


func _on_test_button_pressed():
	get_tree().change_scene_to_file("res://Test/characters_test.tscn")
	pass


func _on_credit_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Menu/credits.tscn")
	pass


func _on_start_game_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Levels/game_scene_1.tscn")
	pass


func _on_continue_button_pressed():
	pass
