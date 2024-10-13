extends Control

var vbox_aux : VBoxContainer
@onready var v_box_container = $Panel/VBoxContainer

func _ready():
	load_volume()
	pass

func _process(delta):
	pass

func _on_back_button_pressed():
	self.hide()
	vbox_aux.show()
	GameManager.save_data()
	pass
	
func show_and_hide(vbox : VBoxContainer):
	vbox_aux = vbox
	vbox.hide()
	show()
	pass

func _on_master_audio_slider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)
	GameManager.game_data.master_volume = value
	pass


func _on_music_audio_slider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), value)
	GameManager.game_data.music_volume = value
	pass


func _on_sfx_audio_slider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), value)
	GameManager.game_data.sfx_volume = value
	pass 
	
func load_volume():
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), GameManager.game_data.music_volume)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), GameManager.game_data.sfx_volume)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), GameManager.game_data.master_volume)
	v_box_container.get_node("MasterAudioSlider").value = GameManager.game_data.master_volume
	v_box_container.get_node("MusicAudioSlider").value = GameManager.game_data.music_volume
	v_box_container.get_node("SFXAudioSlider").value = GameManager.game_data.sfx_volume
	pass
