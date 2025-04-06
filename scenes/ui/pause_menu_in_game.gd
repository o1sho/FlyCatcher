extends Control
@export var time_before_shutdown: float = 3.0

func _ready() -> void:
	visible = true
	await get_tree().create_timer(time_before_shutdown).timeout
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 0.0, 0.6)
