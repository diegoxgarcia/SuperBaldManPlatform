class_name Portal
extends Area2D

@onready var portal_animated_sprite_2d = $PortalAnimatedSprite2D
@onready var collision_shape_2d = $CollisionShape2D

func _ready():
	self.monitorable = false
	pass

func open_portal():
	self.monitorable = true
	portal_animated_sprite_2d.visible = true
	pass
