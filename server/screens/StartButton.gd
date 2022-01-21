extends AudioStreamPlayer

func StartButtonSound():
	var audiostream: AudioStream = preload("res://assets/sounds/New.wav")
	self.set_stream(audiostream)
	self.volume_db = -5
	self.play()
