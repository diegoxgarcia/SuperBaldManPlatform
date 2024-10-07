extends Node2D

@onready var health_progress_bar: TextureProgressBar = $CanvasLayer/UI/HealthPanel/HealthProgressBar
@onready var defeated: Label = $CanvasLayer/UI/EnemyPanel/Defeated
var match_data : MatchData
@onready var player: Player = $Player

func _ready():
	health_progress_bar.value = match_data.player_health
	player.update_match_data.connect(update_player_match_data)
	pass 

func _process(delta):
	pass

func update_player_match_data(health : int, score : int):
	match_data.player_health = health
	health_progress_bar.value = match_data.player_health
	pass
