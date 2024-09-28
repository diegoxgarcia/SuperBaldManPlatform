extends Area2D

signal player_damaged
signal enemy_damaged(area : Area2D)


func _on_body_entered(body):
	player_damaged.emit() # TODO enviar el damage dependiendo del enemigo que entra
	pass


func _on_area_entered(area):
	enemy_damaged.emit(area)
	pass
