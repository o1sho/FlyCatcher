extends StaticBody2D

@onready var animation: AnimationPlayer = $Animation
@export var start_delay: float = 0.0
@onready var camera: Camera = $"../../Camera"


func _ready() -> void:
	await get_tree().create_timer(start_delay).timeout
	animation.play("hit")

func camera_shake():
	pass
	#camera.start_light_shake()
