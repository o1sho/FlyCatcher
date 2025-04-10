extends Node

@export var next_level_instance: PackedScene
@export var level_menu_instance: PackedScene = preload("res://scenes/ui/main_menu_levels.tscn")
@onready var player: Player = $Player
@onready var transition_mask: IngameUI = $IngameUI

@export var is_darkness: bool = false

var current_level: int
var next_level: PackedScene
var next_level_path: String

func _ready() -> void:
	AudioPlayer.play_music_level()
	transition_mask.start_transition_increase(player.global_position)
	
	current_level = int(get_tree().current_scene.name) + 1
	
		# Подготовка к асинхронной загрузке следующей сцены
	next_level_path = next_level_instance.resource_path
	ResourceLoader.load_threaded_request(next_level_path)
	
	if is_darkness:
		pass
	else: 
		return

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().call_deferred("change_scene_to_packed", level_menu_instance)
		AudioPlayer.play_button(-3.0)

func get_next_level() -> PackedScene:
	AudioPlayer.play_switch_level(5.0)
	return next_level_instance
	
func finish_level():
	
	Data.save_progress(current_level)
	
	var current_scene = get_tree().current_scene
	next_level = current_scene.get_next_level()
	if next_level:
		#transition_mask.start_transition_decrease(player.global_position)
		#await transition_mask.tween.finished
		
		get_tree().call_deferred("change_scene_to_packed", next_level)
	else:
		print("Ошибка: следующая сцена не найдена.")
