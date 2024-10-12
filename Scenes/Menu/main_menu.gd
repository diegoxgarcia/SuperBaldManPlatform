extends Control

@onready var animation_player = $AnimationPlayer
@onready var v_box_container = $VBoxContainer

func _ready():
	if GameManager.game_data.checkpoint_level == "":
		v_box_container.get_node("ContinueButton").visible = false
	else:
		v_box_container.get_node("ContinueButton").visible = true
	animation_player.play("title_anim")
	pass


func _on_test_button_pressed():
	get_tree().change_scene_to_file("res://Test/characters_test.tscn")
	pass


func _on_credit_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Menu/credits.tscn")
	pass


func _on_start_game_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Levels/level_1.tscn")
	pass


func _on_continue_button_pressed():
	get_tree().change_scene_to_file(GameManager.game_data.checkpoint_level)
	pass


func _on_audio_pressed():
	pass
