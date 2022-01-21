extends AudioStreamPlayer

var rd = RandomNumberGenerator.new()

func PlayerJumpSound():
	rd.randomize()
	var audiostream: AudioStream = preload("res://assets/sounds/jump.wav")
	self.set_stream(audiostream)
	self.set_pitch_scale(rd.randf_range(1.0, 4.0))
	self.play()
