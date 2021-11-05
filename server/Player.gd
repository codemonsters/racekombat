extends KinematicBody2D

# PLACEHOLDER FUNCIONA SIN MAQUINA DE ESTADOS

var velocity = Vector2()
var velocidad = 300
var gravedad = 800
var velocidadSalto = -400

func getInput():
	velocity.x = 0
	if Input.is_action_pressed("ui_left"):
		velocity.x -= velocidad
	if Input.is_action_pressed("ui_right"):
		velocity.x += velocidad
	if Input.is_action_pressed("ui_accept") and is_on_floor():
		velocity.y = velocidadSalto
	if Input.is_action_pressed("ui_cancel"):
		velocity = Vector2()
		position = Vector2(0, 0)

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravedad * delta
	getInput()
	velocity = move_and_slide(velocity, Vector2(0, -1))
