extends AudioStreamPlayer

func PlayerStartSound():
	var audiostream: AudioStream = preload("res://assets/sounds/playerStart.wav")
	self.set_stream(audiostream)
	self.play()
