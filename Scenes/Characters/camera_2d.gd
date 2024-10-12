extends Camera2D

@export var random_strength : float = 30.0
@export var shake_fade : float = 5.0
@onready var player = $".."

var flag_shake : bool = false

var rng = RandomNumberGenerator.new()
var shake_strength : float = 0.0

func _ready():
	player.portal_opened_shake_cam.connect(shake_camera)
	pass 
	
func _process(delta):
	if flag_shake:
		apply_shake()
		if shake_strength > 0:
			shake_strength = lerpf(shake_strength, 0, shake_fade * delta)
		offset = random_offset()
		await get_tree().create_timer(1.0).timeout
		flag_shake = false
	pass

func apply_shake():
	shake_strength = random_strength
	pass

func random_offset():
	return Vector2(rng.randf_range(-shake_strength, shake_strength), rng.randf_range(-shake_strength, shake_strength))
	pass
	
func shake_camera():
	flag_shake = true
	pass
