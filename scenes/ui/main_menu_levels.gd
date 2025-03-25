extends Control

@onready var transition_mask: IngameUI = $IngameUI
var center


@export var level_buttons_container: GridContainer

func _ready() -> void:
	Data.load_progress()
	
	set_scene_center()
	transition_mask.start_transition_increase(center)
	
	init_level_button()
	
#func _on_play_button():
	#transition_mask.start_transition_decrease(center)
	#await transition_mask.tween.finished
	#get_tree().change_scene_to_file('res://scenes/levels/0_level_start.tscn')

func init_level_button() -> void:
	for button in level_buttons_container.get_children():
		# Соеденение сигналов кнопок с функцией запуска уровня
		if button is Button:
			var level_num = button.name.to_int()
			button.pressed.connect(_on_level_button_pressed.bind(level_num))
			print (button.name, " сигнал подключен.")
			if Data.current_unlocked_level < button.name.to_int():
				button.disabled = true
			
func set_scene_center() -> void:
	var viewport = get_viewport().get_visible_rect()
	center = viewport.size / 2

func _on_level_button_pressed(level_number: int):
	if level_number <= Data.current_unlocked_level:
		var path = "res://scenes/levels/level_%d.tscn" % level_number
		print(path)
		if ResourceLoader.exists(path):
			var button = level_buttons_container.get_children()[level_number - 1]
			#print (button.global_position + button.size / 2)
			transition_mask.start_transition_decrease(button.global_position + button.size / 2)
			await transition_mask.tween.finished
			get_tree().change_scene_to_file(path)
		else:
			print("Уровень %d не найден!" % level_number)
			

#func save_progress():
	#var config = ConfigFile.new()
	#config.set_value("progress", "unlocked", current_unlocked_level)
	#config.save(save_path)
#
#func load_progress():
	#var config = ConfigFile.new()
	#if config.load(save_path) == OK:
		#current_unlocked_level = config.get_value("progress", "unlocked", 1)
