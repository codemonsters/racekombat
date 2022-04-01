extends AudioStreamPlayer

var rd = RandomNumberGenerator.new()

func PlayerStartSound():
	var audiostream: AudioStream = preload("res://assets/sounds/playerStart.mp3")
	self.set_stream(audiostream)
	self.play()


func PlayerStepSound():
	var audiostream: AudioStream = preload("res://assets/sounds/step.mp3")
	self.set_stream(audiostream)
	self.volume_db = 1
	self.play()


func PlayerJumpSound():
	rd.randomize()
	var audiostream: AudioStream = preload("res://assets/sounds/jump.mp3")
	self.set_stream(audiostream)
	self.set_pitch_scale(rd.randf_range(1.0, 4.0))
	self.play()


func PlayerSpawnSound():
	var audiostream: AudioStream = preload("res://assets/sounds/playerSelect.mp3")
	self.set_stream(audiostream)
	self.play()


func StartButtonSound():
	var audiostream: AudioStream = preload("res://assets/sounds/New.mp3")
	self.set_stream(audiostream)
	self.volume_db = -5
	self.play()


func PlayerDeathSound():
	var audiostream: AudioStream = preload("res://assets/sounds/playerDead.mp3")
	self.set_stream(audiostream)
	self.play()


func PlayerDashSound():
	var audiostream: AudioStream = preload("res://assets/sounds/Dash.mp3")
	self.set_stream(audiostream)
	self.set_pitch_scale(1)
	self.play()
