extends Node2D

@onready var health_progress_bar: TextureProgressBar = $CanvasLayer/UI/HealthProgressBar
@onready var defeated: Label = $CanvasLayer/UI/EnemyPanel/Defeated
@export var match_data : MatchData
@onready var player: Player = $Player
@onready var score_progress_bar = $CanvasLayer/UI/ScoreProgressBar
@onready var tile_map_layer = $TileMapLayer
@onready var portal = $Portal

func _ready():
	health_progress_bar.value = match_data.player_health
	score_progress_bar.value = match_data.collectables_taken
	player.update_match_data.connect(update_player_match_data)
	score_progress_bar.max_value = tile_map_layer.get_children().size()
	connect_enemy_signal()
	pass 

func _process(delta):
	pass
	
func connect_enemy_signal():
	var enemies = get_tree().get_nodes_in_group("Enemy")
	for i in enemies.size():
		enemies[i].enemy_dead.connect(update_enemy_defeated)
	pass

func update_player_match_data(health : int, score : int):
	match_data.player_health = health
	health_progress_bar.value = match_data.player_health
	score_progress_bar.value = score
	pass
	
func update_enemy_defeated():
	match_data.enemies_defeated = match_data.enemies_defeated + 1
	defeated.text = " Enemigos derrotados: " + str(match_data.enemies_defeated)
	pass

func _on_score_progress_bar_value_changed(value):
	if value == score_progress_bar.max_value:
		portal.open_portal()
	pass
