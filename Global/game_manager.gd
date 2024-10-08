extends Node

const savefile = "user://SAVEFILE.save"
var match_data = MatchData.new()

var game_data = {
	"record" : 0,
	"checkpoint_level" : 0
}

func dir_contents(path):
	var dir = DirAccess.open(path)
	var index = 0
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "" && file_name.contains(".tscn"):
			if dir.current_is_dir():
				print("Found directory: " + file_name)
			else:
				match_data.levels.append(file_name)
				print("Found levels: " + str(match_data.levels))
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")


func _ready():
	dir_contents("res://Scenes/Levels/")
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
