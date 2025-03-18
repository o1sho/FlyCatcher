extends Area2D

@export var point_a: Vector2 
@export var point_b: Vector2
@export var speed: float = 100
@export var rotation_speed: float = 180

var target_point: Vector2

func _ready() -> void:
	target_point = point_b

func _physics_process(delta: float) -> void:

	global_position = global_position.move_toward(target_point, speed * delta)
	

	if global_position.distance_to(target_point) < 1:
		target_point = point_a if target_point == point_b else point_b
	

	rotation += deg_to_rad(rotation_speed * delta)
