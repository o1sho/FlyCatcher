extends ColorRect

var tween: Tween

func _ready() -> void:
	mouse_filter = MOUSE_FILTER_IGNORE

func start_transition() -> void:
	# Центр экрана вместо позиции родителя
	var viewport_size = get_viewport_rect().size
	var center = viewport_size / 2.0
	material.set_shader_parameter("center", center / viewport_size)
	
	# Удаляем старый твин если есть
	if tween:
		tween.kill()
	
	# Анимация
	tween = create_tween().set_ease(Tween.EASE_IN_OUT)
	tween.tween_method(set_radius, 1.0, 0.0, 0.7)

func set_radius(value: float) -> void:
	material.set_shader_parameter("radius", value)
