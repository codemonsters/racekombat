extends AudioStreamPlayer

func PlayerSpawnSound():
	var audiostream: AudioStream = preload("res://assets/sounds/playerSelect.wav")
	self.set_stream(audiostream)
	self.play()
