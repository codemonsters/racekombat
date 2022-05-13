extends Control

const SPEED = 50

var manager
var target_position := 0
var in_reduced_mode := false

onready var min_pos = $Other/Deaths/Skull.rect_size.x * $Other/Deaths/Skull.rect_scale.x

func _ready():
	$Colored/Bar.color.a = .8
	$"Colored/Reduced Bar".color.a = .8
	$Colored/UI/Border.border_color.a = 1
	$Colored/UI/Background.color.a = .3
	$"Colored/UI/Wins BG".color = Color.darkgray
	$"Colored/Reduced Bar".visible = false
	
	$Colored/Bar.rect_size.x = get_parent().rect_size.x
	$"Colored/Reduced Bar".rect_size.x = min_pos
	
	$"Colored/Reduced Bar".rect_position.x = get_parent().rect_size.x - min_pos
	
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
		target_position = get_parent().rect_size.x - max(get_parent().rect_size.x * score / manager.total_score, min_pos)
	else:
		target_position = 0

func _update_other(stat, new_amount):
	match stat:
		"deaths":
			$Other/Deaths/Label.text = str(new_amount)
		"wins":
			$Other/Wins/Label.text = str(new_amount)

func _change_visibility(target, value):
	match target:
		"ui":
			$Colored/UI.visible = value
		"deaths":
			$Other/Deaths.visible = value
		"wins":
			$Other/Wins.visible = value

func _change_to_reduced_mode(to_reduced_mode):
	if to_reduced_mode and not in_reduced_mode:
		in_reduced_mode = true
		$Colored/Bar.visible = false
		$"Colored/Reduced Bar".visible = true
		_change_visibility("deaths", false)
		
		rect_min_size.y = 10
		rect_size.y = rect_min_size.y
	elif not to_reduced_mode and in_reduced_mode:
		in_reduced_mode = false
		$Colored/Bar.visible = true
		$"Colored/Reduced Bar".visible = false
		_change_visibility("deaths", true)
		
		rect_min_size.y = 40
		rect_size.y = rect_min_size.y
