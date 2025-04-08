class_name Camera
extends Camera2D

@export var shake_power: float = 4.0    # Сила тряски
@export var shake_duration: float = 0.3 # Длительность в секундах

var is_shaking: bool = false
var initial_offset: Vector2

func _ready() -> void:
	initial_offset = offset
	
func start_shake() -> void:
	if is_shaking: 
		return
	
	is_shaking = true
	var tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	
	# Генерация случайной тряски
	for i in range(8):
		var rand_offset = Vector2(
			randf_range(-shake_power, shake_power),
			randf_range(-shake_power, shake_power)
		)
		tween.tween_property(self, "offset", rand_offset, shake_duration / 8)
	
	tween.tween_property(self, "offset", initial_offset, shake_duration / 8)
	tween.finished.connect(_on_shake_finished)

func start_light_shake() -> void:
	if is_shaking: 
		return
	
	is_shaking = true
	var tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	
	# Генерация случайной тряски
	for i in range(8):
		var rand_offset = Vector2(
			randf_range(-shake_power/4, shake_power/4),
			randf_range(-shake_power/4, shake_power/4)
		)
		tween.tween_property(self, "offset", rand_offset, shake_duration / 8)
	
	tween.tween_property(self, "offset", initial_offset, shake_duration / 8)
	tween.finished.connect(_on_shake_finished)


func _on_shake_finished() -> void:
	is_shaking = false
	offset = initial_offset	
