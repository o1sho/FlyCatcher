extends Node

@export var next_level_instance: PackedScene
@onready var player: Player = $Player
@onready var transition_mask: IngameUI = $IngameUI

func _ready() -> void:
	transition_mask.start_transition_increase(player.global_position)

func get_next_level() -> PackedScene:
	return next_level_instance
	
func finish_level():
	transition_mask.start_transition_decrease(player.global_position)
	await transition_mask.tween.finished
	
	var current_scene = get_tree().current_scene
	var next_level = current_scene.get_next_level()
	if next_level:
		get_tree().call_deferred("change_scene_to_packed", next_level)
	else:
		print("Ошибка: следующая сцена не найдена.")
