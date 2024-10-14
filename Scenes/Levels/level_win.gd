extends Node2D

@onready var you_label = $CanvasLayer/Credits/YouLabel
@onready var win_label = $CanvasLayer/Credits/WinLabel

func _ready():
	pass


func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene_to_file("res://Scenes/Menu/main_menu.tscn")
	else:
		you_label.modulate = Color.from_hsv((randi() % 12) / 12.0, 1, 1)
		win_label.modulate = Color.from_hsv((randi() % 12) / 12.0, 1, 1)
		await get_tree().create_timer(0.5).timeout
	pass


func _on_animation_player_animation_finished(anim_name):
	match anim_name:
		"credits_slide":
			get_tree().change_scene_to_file("res://Scenes/Menu/main_menu.tscn")
	pass
