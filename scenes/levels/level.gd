extends Node

@export var next_level_instance: PackedScene

func get_next_level() -> PackedScene:
	return next_level_instance
	
func finish_level():
	var current_scene = get_tree().current_scene
	var next_level = current_scene.get_next_level()
	if next_level:
		get_tree().call_deferred("change_scene_to_packed", next_level)
	else:
		print("Ошибка: следующая сцена не найдена.")
