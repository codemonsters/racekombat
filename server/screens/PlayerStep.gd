extends AudioStreamPlayer

func PlayerStepSound():
	var audiostream: AudioStream = preload("res://assets/sounds/step.wav")
	self.set_stream(audiostream)
	self.volume_db = 1
	self.play()
