class_name IngameUI
extends CanvasLayer

@onready var transition_mask: ColorRect = $TransitionMask
var tween: Tween

func _ready() -> void:
	transition_mask.mouse_filter = Control.MOUSE_FILTER_IGNORE

func start_transition_decrease(target_position: Vector2, duration: float = 0.7) -> void:

	#transition_mask.visible = true
	set_radius(1.0)
	var viewport_size = get_viewport().get_visible_rect().size
	
	var center_uv = target_position / viewport_size
	transition_mask.material.set_shader_parameter("center", center_uv)
	
	tween = create_tween().set_ease(Tween.EASE_IN_OUT)
	tween.tween_method(set_radius, 1.0, 0.0, duration)
	await tween.finished

	
func start_transition_increase(target_position: Vector2, duration: float = 0.7) -> void:

	#transition_mask.visible = true
	set_radius(0.0)
	var viewport_size = get_viewport().get_visible_rect().size
	
	var center_uv = target_position / viewport_size
	transition_mask.material.set_shader_parameter("center", center_uv)
	
	tween = create_tween().set_ease(Tween.EASE_IN_OUT)
	tween.tween_method(set_radius, 0.0, 1.0, duration)
	await tween.finished
	#transition_mask.visible = false

func set_radius(value: float) -> void:
	transition_mask.material.set_shader_parameter("radius", value)
