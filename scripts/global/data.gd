extends Node

var current_unlocked_level: int = 1
const SAVE_PATH: String = "user://save.cfg"
var current_level: int

var is_sound_enabled: bool = true:
	set(value):
		is_sound_enabled = value
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), !value)
		save_all_settings()  # Изменили здесь

func save_progress(new_level: int) -> void:
	if new_level > current_unlocked_level:
		current_unlocked_level = new_level
		save_all_settings()  # Изменили здесь
		print("Прогресс сохранен: уровень ", current_unlocked_level)

func save_all_settings() -> void:
	var config = ConfigFile.new()
	# Загружаем текущие данные перед сохранением
	var err = config.load(SAVE_PATH)
	if err != OK:
		config = ConfigFile.new()
	
	# Сохраняем оба типа данных
	config.set_value("progress", "unlocked_level", current_unlocked_level)
	config.set_value("audio", "sound_enabled", is_sound_enabled)
	
	config.save(SAVE_PATH)

func load_all_settings() -> void:
	var config = ConfigFile.new()
	var err = config.load(SAVE_PATH)
	if err == OK:
		current_unlocked_level = config.get_value("progress", "unlocked_level", 1)
		is_sound_enabled = config.get_value("audio", "sound_enabled", true)
		print("Данные загружены: уровень ", current_unlocked_level, ", звук ", is_sound_enabled)
	else:
		print("Сохранение не найдено, установлены значения по умолчанию")
		current_unlocked_level = 1
		is_sound_enabled = true

func reset_progress() -> void:
	current_unlocked_level = 1
	save_all_settings()  # Сохраняем сброс прогресса
	print("Весь прогресс сброшен!")

func toggle_sound():
	is_sound_enabled = !is_sound_enabled
