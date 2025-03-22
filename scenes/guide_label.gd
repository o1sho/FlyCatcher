extends CanvasLayer

@onready var label_1: Label = $Label
@onready var label_2: Label = $Label2

var game_start: bool = false

func _ready() -> void:
	label_1.modulate.a = 0.0
	label_2.modulate.a = 0.0
		
	var tween = create_tween()
	tween.tween_property(label_1, "modulate:a", 0.5, 2.0)
	
	var game_manager = get_tree().root.find_child("GameManager", true, false)
	game_manager.first_fly_caught.connect(hide_guide)
	

func hide_guide() -> void:
	var tween = create_tween()
	tween.tween_property(label_1, "modulate:a", 0.0, 0.5)
	tween.tween_callback(label_1.queue_free)
	
	unhide_finish_guide()
	#await get_tree().create_timer(1.0).timeout
	#unhide_finish_guide()
	#tween.tween_callback(unhide_finish_guide)

func unhide_finish_guide() -> void:
		
	var tween = create_tween()
	tween.tween_property(label_2, "modulate:a", 0.5, 1.0)
	#tween.tween_callback(label_2.queue_free)
