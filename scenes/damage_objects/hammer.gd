extends StaticBody2D

@onready var animation: AnimationPlayer = $Animation
@export var start_delay: float = 0.0

func _ready() -> void:
	await get_tree().create_timer(start_delay).timeout
	animation.play("hit")
