extends Node2D

@onready var ray_cast_player_front : RayCast2D = $RayCastPlayerFront
@onready var ray_cast_player_back : RayCast2D = $RayCastPlayerBack

var player_detected : Player = null

func clear_target_position():
	ray_cast_player_back.enabled = false
	ray_cast_player_front.enabled = false
	pass

func set_target_position(target_position_x : float):
	ray_cast_player_back.target_position.x = target_position_x
	ray_cast_player_front.target_position.x = -1 * target_position_x
	pass
	
func check_player_collide() -> Player:	
	if ray_cast_player_front.is_colliding():
		player_detected = ray_cast_player_front.get_collider()
		return player_detected
	elif ray_cast_player_back.is_colliding():
		player_detected = ray_cast_player_back.get_collider()
		return player_detected
	else:
		return player_detected
pass
