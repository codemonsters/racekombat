extends AudioStreamPlayer

var new: AudioStream = preload("res://assets/sounds/New.mp3")

func CourseEnter():
	self.set_stream(new)
	self.volume_db = -5
	self.set_pitch_scale(1)
	self.play()
