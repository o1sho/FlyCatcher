extends AudioStreamPlayer2D

const level_music = preload("res://assets/sounds/sound voron VT ver2.ogg")
const fly_up_sound = preload("res://assets/sounds/fly_up.ogg")
const catch_sound = preload("res://assets/sounds/catch.ogg")
const switch_level_sound = preload("res://assets/sounds/level.ogg")
const death_sound = preload("res://assets/sounds/death_2.ogg")
const additional_sound = preload("res://assets/sounds/death_1.ogg")
const button_sound = preload("res://assets/sounds/button.ogg")

func _play_music(music: AudioStream, volume = 6.0):
	if stream == music:
		return
		
	stream = music
	volume_db = volume
	play()
	
func play_music_level():
	_play_music(level_music)
	
func play_fly_up(volume = 0.0, player_position: Vector2 = Vector2.ZERO):
	one_shot_sound(fly_up_sound, volume, player_position)

func play_catch(volume = 0.0, fly_position: Vector2 = Vector2.ZERO):
	one_shot_sound(catch_sound, volume, fly_position)
	
func play_switch_level(volume = 0.0, player_position: Vector2 = Vector2.ZERO):
	one_shot_sound(switch_level_sound, volume, player_position)
	
func play_death(volume = 0.0, player_position: Vector2 = Vector2.ZERO):
	one_shot_sound(death_sound, volume, player_position)
	
func play_additional(volume = 0.0, player_position: Vector2 = Vector2.ZERO):
	one_shot_sound(additional_sound, volume, player_position)
	
func play_button(volume = 0.0, player_position: Vector2 = Vector2.ZERO):
	one_shot_sound(button_sound, volume, player_position)
	
func one_shot_sound(stream, volume: float = 0.0, position: Vector2 = Vector2.ZERO):
	var sound = AudioStreamPlayer2D.new()
	sound.bus = "one_shot_sound"
	sound.stream = stream
	sound.volume_db = volume
	sound.global_position = position
	add_child(sound)
	sound.play()
	sound.finished.connect(sound.queue_free)
