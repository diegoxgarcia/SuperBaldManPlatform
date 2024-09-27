class_name PeaMonsterEnemy
extends MonsterEnemy

func _ready():
	proximity_player_detector.set_target_position(enemy_data.target_position)
	pass

func _physics_process(delta):
	fall(delta)
	follow_player()
	direction_flip()
	move_and_slide()
	
func _process(delta):
	player = proximity_player_detector.check_player_collide()
	pass	

func _on_damager_enemy_damaged():
	#animation_player.play("hit")
	pass # Replace with function body.
