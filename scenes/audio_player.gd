extends AudioStreamPlayer2D

const level_music = preload("res://assets/sounds/sound voron VT ver2.mp3")

func _play_music(music: AudioStream, volume = 2.0):
	if stream == music:
		return
		
	stream = music
	volume_db = volume
	play()
	
func play_music_level():
	_play_music(level_music)
