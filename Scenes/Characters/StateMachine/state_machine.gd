class_name StateMachine
extends Node

@export var initial_state : State

var current_state : State
var states : Dictionary = {}

func _ready():
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.transitioned.connect(on_child_transition)
	if initial_state:
		initial_state.enter()
		current_state = initial_state
	pass
		
func _process(delta):
	if current_state:
		current_state.update(delta)
	pass
	
func _physics_process(delta):
	if current_state:
		current_state.physics_update(delta)
	pass

func on_child_transition(state, new_state_name):
	# Verificamos si el estado actual es distinto al estado que esta llamando por una transicion a un nuevo estado
	# Si el estado es distinto, no lo escucho, ya que solo estare esperando al estado actual y que el cambio lo pida ese estado
	if state != current_state:
		return
	# Verifico que el nuevo estado a donde quiere transicionar exista en el dictionary, si no exista, salgo
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		return
	# Si tenemos un estado actual, salgo del mismo para darle lugar a entrar a el nuevo estado
	if current_state:
		current_state.exit()
		
	new_state.enter()
	# Seteo el nuevo estado como estado actual
	current_state = new_state
	
	pass
