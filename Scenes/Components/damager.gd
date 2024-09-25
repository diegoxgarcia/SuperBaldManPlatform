extends Area2D

signal player_damaged
signal enemy_damaged


func _on_body_entered(body):
	player_damaged.emit() # TODO enviar el damage dependiendo del enemigo que entra
	pass


func _on_area_entered(area):
	enemy_damaged.emit() # TODO enviar el damage dependiendo del arma que entra
	pass
