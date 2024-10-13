extends Node

const savefile = "user://SAVEFILE.save"
const level_path = "res://Scenes/Levels/"
var match_data = MatchData.new()

var game_data = {
	"score" : 0,
	"checkpoint_level" : "",
	"master_volume" : 0.0,
	"music_volume" : 0.0,
	"sfx_volume" : 0.0
}

func save_checkpoint_record(score : int, checkpoint : String):
	game_data.score = score
	game_data.checkpoint_level = checkpoint
	save_data()
	pass
	
func get_next_level(level : String) -> String:
	var index = int(level.replace("level_", ""))
	index = index + 1
	var next_level = "level_" + str(index)
	if match_data.levels.has(next_level):
		return level_path + next_level + ".tscn"
	else:
		return level_path + match_data.levels.pop_back() + ".tscn"
	pass

func dir_contents(path):
	var dir = DirAccess.open(path)
	var index = 0
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				print("Found directory: " + file_name)
			else:
				if file_name.contains(".tscn"):
					match_data.levels.append(file_name.replace(".tscn", ""))
			file_name = dir.get_next()
		match_data.levels.sort()
	else:
		print("An error occurred when trying to access the path.")

func _ready():
	match_data.player_health = 100
	dir_contents(level_path)
	load_data()
	pass

func load_data():
	var file = FileAccess.open(savefile, FileAccess.READ)
	if file == null:
		save_data()
	else:
		game_data = file.get_var()
	file = null
	pass

func save_data():
	var file = FileAccess.open(savefile,FileAccess.WRITE)
	file.store_var(game_data)
	file = null
	pass
