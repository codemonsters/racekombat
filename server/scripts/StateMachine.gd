class_name StateMachine
extends Node

# Se emite al pasar a otro estado
signal transitioned(stateName)

# Camino al estado inicial
export var initialState := NodePath()
onready var state: State = get_node(initialState)


func _ready() -> void:
	# Espera a recibir "ready" del jugador
	yield(owner, "ready")
	# Se autoasigna los estados
	for child in get_children():
		child.stateMachine = self
	state.enter()


# Delega los procesos a cada estado
func _unhandled_input(event: InputEvent) -> void:
	state.handleInput(event)


func _process(delta: float) -> void:
	state.update(delta)


func _physics_process(delta: float) -> void:
	state.physicsUpdate(delta)


# Llama al exit() del estado actual, cambia de estado y llama a su enter()
func transitionTo(targetStateName: String, msg: Dictionary = {}) -> void:
	if not has_node(targetStateName):
		return

	state.exit()
	state = get_node(targetStateName)
	state.enter(msg)
	emit_signal("transitioned", state.name)
