extends Control

export(String) var button_name

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Improved draw circle function (built in draw_circle() is pixelated)
func draw_circle_custom(radius, color, maxerror = 0.1):

	if radius <= 0.0:
		return

	var maxpoints = 1024 # I think this is renderer limit

	var numpoints = ceil(PI / acos(1.0 - maxerror / radius))
	numpoints = clamp(numpoints, 3, maxpoints)

	var points = PoolVector2Array([])

	for i in numpoints:
		var phi = i * PI * 2.0 / numpoints
		var v = Vector2(sin(phi), cos(phi))
		points.push_back(v * radius)

	draw_colored_polygon(points, color)


func _draw():
	draw_circle_custom(70, Color(0, 0, 1))
	$Label.text = button_name
	#draw_circle(Vector2(0,0), 70, Color(0, 0, 1))



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
