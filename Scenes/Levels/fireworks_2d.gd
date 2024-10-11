extends GPUParticles2D


# Called when the node enters the scene tree for the first time.
func _ready():
	process_material.sub_emitter_amount_at_end = 200
	pass 
