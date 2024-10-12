extends Control

var vbox_aux : VBoxContainer

func _process(delta):
	pass


func _on_back_button_pressed():
	self.hide()
	vbox_aux.show()
	pass
	
func show_and_hide(vbox : VBoxContainer):
	vbox_aux = vbox
	vbox.hide()
	show()
	pass

func _on_master_audio_slider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)
	pass


func _on_music_audio_slider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), value)
	pass


func _on_sfx_audio_slider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), value)
	pass 
