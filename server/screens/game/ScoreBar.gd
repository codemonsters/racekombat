extends Control

const SPEED = 50

var manager
var target_position := 0

func _ready():
	$Colored/Bar.color.a = .8
	$Colored/UI/Border.border_color.a = 1
	$Colored/UI/Background.color.a = .3
	$"Colored/UI/Deaths BG".color = Color.darkgray
	$"Colored/UI/Wins BG".color = Color.darkgray
	
	$Colored/Bar.rect_size.x = get_parent().rect_size.x
	
	manager.waiting_room.connect("run_started", self, "_change_other_visibility")
	manager.waiting_room.connect("run_ended", self, "_change_other_visibility")

func _process(delta):
	if $Colored/Bar.rect_position.x < target_position:
		$Colored/Bar.rect_position.x += SPEED * delta
	elif $Colored/Bar.rect_position.x > target_position:
		$Colored/Bar.rect_position.x -= SPEED * delta
	$Colored/Bar.rect_position.x = round($Colored/Bar.rect_position.x)

func _update_score(score, total_score):
	if total_score != 0:
		target_position = get_parent().rect_size.x - get_parent().rect_size.x * score / manager.total_score
	else:
		target_position = 0

func _update_other(stat, new_amount):
	match stat:
		"deaths":
			$Other/Deaths.text = str(new_amount)
		"wins":
			$Other/Wins.text = str(new_amount)

func _change_other_visibility():
	$Colored/UI.visible = not $Colored/UI.visible
	$Other.visible = not $Other.visible
