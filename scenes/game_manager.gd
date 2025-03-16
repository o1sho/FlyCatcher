class_name GameManager
extends Node

var flies_for_victory: int = 0
var flies_collected: int = 0

signal first_fly_caught
signal all_flies_caught

func _ready() -> void:
	var flies_at_level = get_tree().get_nodes_in_group("fly").size()
	flies_for_victory = flies_at_level
	print ("Мух на уровне: ", flies_for_victory)



func add_fly() -> void:
	flies_collected += 1
	print ("Мух собрано: ", flies_collected)
	first_fly_caught.emit()
	check_flies()
	
func check_flies() -> void:
	if flies_collected >= flies_for_victory:
		all_flies_caught.emit()

#func check_victory():
	#if flies_collected >= flies_for_victory:
		#var current_scene = get_tree().current_scene
		#var next_level = current_scene.get_next_level()
		#if next_level:
			#get_tree().call_deferred("change_scene_to_packed", next_level)
		#else:
			#print("Ошибка: следующая сцена не найдена.")
		#
