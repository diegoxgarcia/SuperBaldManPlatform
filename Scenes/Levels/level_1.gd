class_name Level1
extends Node2D

@onready var health_progress_bar: TextureProgressBar = $CanvasLayer/UI/HealthProgressBar
@onready var defeated: Label = $CanvasLayer/UI/EnemyPanel/Defeated
@onready var player: Player = $Player
@onready var score_progress_bar = $CanvasLayer/UI/ScoreProgressBar
@onready var tile_map_layer = $TileMapLayer
@onready var portal = $Portal
@onready var ui_animation_player = $CanvasLayer/UI/UIAnimationPlayer
@onready var portal_label = $CanvasLayer/UI/PortalLabel
@onready var v_box_container = $CanvasLayer/UI/VBoxContainer
var level_score : int = 0
@onready var trans_animation_player = $CanvasLayer/Fade/TransAnimationPlayer

func _ready():
	health_progress_bar.value = player.player_data.health
	score_progress_bar.value = level_score
	player.update_match_data.connect(update_player_match_data)
	player.update_match_score_data.connect(update_player_match_data_score)
	score_progress_bar.max_value = tile_map_layer.get_children().size()
	connect_enemy_signal()
	pass 

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		open_menu(false)
	pass
	
func open_menu(game_over : bool):
	if !game_over:
		get_tree().paused = true
	v_box_container.visible = true
	pass
	
func connect_enemy_signal():
	var enemies = get_tree().get_nodes_in_group("Enemy")
	for i in enemies.size():
		enemies[i].enemy_dead.connect(update_enemy_defeated)
	pass
	
func update_player_match_data_score():
	level_score = level_score + 1
	score_progress_bar.value = level_score
	GameManager.match_data.collectables_taken = level_score
	pass

func update_player_match_data(health : int):
	GameManager.match_data.player_health = health
	health_progress_bar.value = GameManager.match_data.player_health
	if health <= 0:
		ui_animation_player.play("game_over")
	pass
	
func update_enemy_defeated():
	GameManager.match_data.enemies_defeated = GameManager.match_data.enemies_defeated + 1
	defeated.text = " Defeated enemies: " + str(GameManager.match_data.enemies_defeated)
	pass

func _on_score_progress_bar_value_changed(value):
	if value == score_progress_bar.max_value:
		portal_label.visible = true
		portal.open_portal()
	pass

func _on_continue_button_pressed():
	v_box_container.visible = false
	get_tree().paused = false
	pass

func _on_exit_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/Menu/main_menu.tscn")
	pass

func _on_ui_animation_player_animation_finished(anim_name):
	match anim_name:
		"game_over":
			v_box_container.get_node("ContinueButton").visible = false
			open_menu(true)
		
	pass

func _on_player_go_to_next_level():
	trans_animation_player.play("fade_in")
	pass


func _on_trans_animation_player_animation_finished(anim_name):
	match anim_name:
		"fade_in":
			var next_level = GameManager.get_next_level(self.name.to_lower())
			GameManager.save_checkpoint_record(GameManager.match_data.collectables_taken, next_level)
			get_tree().change_scene_to_file(next_level)
	pass 
