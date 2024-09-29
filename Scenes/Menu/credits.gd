extends Control

@onready var animation_player = $AnimationPlayer

func _ready():
	animation_player.play("slide_up_credits")
	pass

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		_back_to_main_menu()

func _back_to_main_menu():
	get_tree().change_scene_to_file("res://Scenes/Menu/main_menu.tscn")
	pass
