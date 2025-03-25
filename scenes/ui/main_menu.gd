extends Control

@onready var transition_mask: IngameUI = $IngameUI

var center

func _ready() -> void:
	%play.pressed.connect(_on_play_button)
	
	set_scene_center()
	
	transition_mask.start_transition_increase(center)
	
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		_on_play_button()
	
func _on_play_button():
	transition_mask.start_transition_decrease(center)
	await transition_mask.tween.finished
	get_tree().change_scene_to_file('res://scenes/ui/main_menu_levels.tscn')


func set_scene_center() -> void:
	var viewport = get_viewport().get_visible_rect()
	center = viewport.size / 2
