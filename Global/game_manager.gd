extends Node

const savefile = "user://SAVEFILE.save"
@export var match_data : MatchData

var game_data = {
	"record" : 0,
	"checkpoint_level" : 0
}

func _ready():
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
