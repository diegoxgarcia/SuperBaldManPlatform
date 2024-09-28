class_name PeaMonsterEnemy
extends MonsterEnemy

func _ready():
	$Visual/Damager.enemy_damaged.connect(_on_damager_enemy_damaged)
	proximity_player_detector.set_target_position(enemy_data.target_position)
	health_bar.value = enemy_data.health
	pass

func _physics_process(delta):
	fall(delta)
	follow_player()
	direction_flip()
	move_and_slide()
	pass
	
func _process(delta):
	player = proximity_player_detector.check_player_collide()
	pass	

func _on_damager_enemy_damaged(area):
	enemy_damaged("hit_rotate", "hit_rotate_backwards", area)
	pass
