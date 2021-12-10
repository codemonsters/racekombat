extends Node2D

export var radio_vector = Vector2(100, 100)
export var platform_width = 100

onready var rotation_tween = get_node("RotationTween")
export var initial_angle := 0
export var amplitude := 0
var final_angle := 0
var tween_angle_values := []
export var period := 0.0

func _ready():
	final_angle = initial_angle - amplitude
	tween_angle_values = [initial_angle, final_angle]
	$Pivot/Plataforma.position = radio_vector
	$Pivot/Plataforma/ColorRect.rect_size = Vector2(platform_width, 10)
	$Pivot/Plataforma/ColorRect.rect_position.x -= platform_width/2
	var coll_size = $Pivot/Plataforma/ColorRect.rect_size / 2
	$Pivot/Plataforma/CollisionShape2D.shape.extents = coll_size
	$Pivot/Plataforma/CollisionShape2D.position += coll_size - Vector2(platform_width/2, 0)
	start_rotation_tween()

func start_rotation_tween():
	rotation_tween.interpolate_property($Pivot, "rotation_degrees",
		tween_angle_values[0], tween_angle_values[1], 2,
		Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	rotation_tween.start()

func _on_RotationTween_tween_completed(object, key):
	tween_angle_values.invert()
	start_rotation_tween()

func _process(delta):
	$Pivot/Plataforma.rotation_degrees = -$Pivot.rotation_degrees # Para que la plataforma quede horizontal.
	update()

func _draw():
	draw_line(Vector2(0,0), radio_vector.rotated(deg2rad($Pivot.rotation_degrees)), Color(1.0, 0, 0), 5)
