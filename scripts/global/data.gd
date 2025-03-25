extends Node

var current_unlocked_level: int = 1
const SAVE_PATH: String = "user://save.cfg"


func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("save_reset"):
		reset_progress()

func save_progress(new_level: int) -> void:
	if new_level > current_unlocked_level:
		current_unlocked_level = new_level
		var config = ConfigFile.new()
		config.set_value("progress", "unlocked_level", current_unlocked_level)
		config.save(SAVE_PATH)
		print("Прогресс сохранен: уровень ", current_unlocked_level)

func load_progress() -> void:
	var config = ConfigFile.new()
	var err = config.load(SAVE_PATH)
	if err == OK:
		current_unlocked_level = config.get_value("progress", "unlocked_level", 1)
		print("Прогресс загружен: уровень ", current_unlocked_level)
	else:
		print("Сохранение не найдено, начинаем с первого уровня")
		current_unlocked_level = 1

func reset_progress() -> void:
	var dir = DirAccess.open("user://")
	if dir.file_exists(SAVE_PATH):
		dir.remove(SAVE_PATH)
		
	current_unlocked_level = 1
	print("Весь прогресс сброшен!")
