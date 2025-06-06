extends ColorRect

@onready var player: Player = get_tree().current_scene.get_node("Player")
var tween: Tween


func _ready() -> void:
	tween = create_tween()
	tween.tween_method(set_radius, 0.0, 1.0, 1.0)

func start_transition_between_level() -> void:
	var viewport_size = get_viewport_rect().size
	material.set_shader_parameter("viewport_size", viewport_size)

	material.set_shader_parameter("center", player.global_position / get_viewport_rect().size)
	
	tween = create_tween()
	tween.tween_method(set_radius, 1.0, 0.0, 1.0)

func set_radius(value: float) -> void:
	material.set_shader_parameter("radius", value)
