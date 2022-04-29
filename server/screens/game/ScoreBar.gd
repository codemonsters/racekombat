extends Control

var manager

func _ready():
	$Colored/Bar.color.a = .8
	$Colored/UI/Border.border_color.a = 1
	$Colored/UI/Background.color.a = .3
	$"Colored/UI/Deaths BG".color = Color.darkgray
	$"Colored/UI/Wins BG".color = Color.darkgray
	
	manager.waiting_room.connect("run_started", self, "_change_other_visibility")
	manager.waiting_room.connect("run_ended", self, "_change_other_visibility")

func _update_score(score, total_score):
	if total_score != 0:
		$Colored/Bar.rect_size.x = get_parent().rect_size.x * score / manager.total_score
		$Colored/Bar.rect_position.x = get_parent().rect_size.x - $Colored/Bar.rect_size.x
	else:
		$Colored/Bar.rect_size.x = get_parent().rect_size.x

func _update_other(stat, new_amount):
	match stat:
		"deaths":
			$Other/Deaths.text = str(new_amount)
		"wins":
			$Other/Wins.text = str(new_amount)

func _change_other_visibility():
	$Colored/UI.visible = not $Colored/UI.visible
	$Other.visible = not $Other.visible
