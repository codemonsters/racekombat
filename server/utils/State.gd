class_name State
extends Node

# Guarda el padre
var state_machine = null


# Corresponde a _unhandled_input
func handleInput(_event: InputEvent) -> void:
	pass


# Corresponde a _process()
func update(_delta: float) -> void:
	pass


# Corresponde a _physics_process()
func physicsUpdate(_delta: float) -> void:
	pass


# Se llama cuando entra
func enter(_msg := {}) -> void:
	pass


# Se llama cuando sale
func exit() -> void:
	pass


# Se llama para calcular posiciones de forma fiable
func _integrate_forces(state) -> void:
	pass
