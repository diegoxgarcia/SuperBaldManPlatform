extends Control

@onready var animation_player = $AnimationPlayer
@onready var v_box_container = $VBoxContainer
@onready var audio_menu = $AudioMenu
@onready var how_to_play_panel = $HowToPlayPanel

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
	audio_menu.show_and_hide(v_box_container)
	pass


func _on_how_to_play_button_pressed():
	v_box_container.hide()
	how_to_play_panel.show()
	pass


func _on_close_button_pressed():
	how_to_play_panel.hide()
	v_box_container.show()
	pass
