extends Control

var manager

func _ready():
	$Colored/Bar.color.a = .8
	$Colored/Border.border_color.a = 1
	$Colored/Background.color.a = .3
	$"Colored/Deaths BG".color = Color.darkgray
	$"Colored/Wins BG".color = Color.darkgray

func _update_score(score, total_score):
	if total_score != 0:
		$Colored/Bar.rect_size.x = get_parent().rect_size.x * score / manager.total_score
	else:
		$Colored/Bar.rect_size.x = get_parent().rect_size.x

func _update_other(stat, new_amount):
	match stat:
		"deaths":
			$Other/Deaths.text = str(new_amount)
		"wins":
			$Other/Wins.text = str(new_amount)
