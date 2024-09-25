extends Area2D

signal player_collected


func _on_area_entered(area):
	player_collected.emit(area)
	pass 
