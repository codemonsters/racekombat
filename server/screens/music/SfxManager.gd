extends AudioStreamPlayer

var rd = RandomNumberGenerator.new()
var jump: AudioStream = preload("res://assets/sounds/jump.mp3")
var player_start: AudioStream = preload("res://assets/sounds/playerStart.mp3")
var step: AudioStream = preload("res://assets/sounds/step.mp3")
var player_spawn: AudioStream = preload("res://assets/sounds/playerSelect.mp3")
var player_dead: AudioStream = preload("res://assets/sounds/playerDead.mp3")
var dash: AudioStream = preload("res://assets/sounds/Dash.mp3")
var dash_bar: AudioStream = preload("res://assets/sounds/DashBar.mp3")

func PlayerStartSound():
	self.set_stream(player_start)
	self.set_pitch_scale(1)
	self.volume_db = -10
	self.play()

func PlayerStepSound():
	self.set_stream(step)
	self.volume_db = 1
	self.play()

func PlayerJumpSound():
	rd.randomize()
	self.set_stream(jump)
	self.set_pitch_scale(rd.randf_range(1.0, 3.0))
	self.play()

func PlayerSpawnSound():
	self.set_stream(player_spawn)
	self.set_pitch_scale(1)
	self.play()

func PlayerDeathSound():
	self.set_stream(player_dead)
	self.set_pitch_scale(1)
	self.play()

func PlayerDashSound():
	self.set_stream(dash)
	self.set_pitch_scale(1)
	self.play()

func PlayerDashBarSound():
	self.set_stream(dash_bar)
	self.set_pitch_scale(1)
	self.play()
