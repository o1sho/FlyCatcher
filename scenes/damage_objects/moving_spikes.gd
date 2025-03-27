extends Area2D

@export var point_a: Vector2 
@export var point_b: Vector2
@export var speed: float = 100
@export var rotation_speed: float = 180

@export var not_move: bool = false

var target_point: Vector2

func _ready() -> void:
	target_point = point_b
	
	if not_move:
		point_a = global_position
		point_b = global_position
		speed = 0

func _physics_process(delta: float) -> void:

	global_position = global_position.move_toward(target_point, speed * delta)
	

	if global_position.distance_to(target_point) < 1:
		target_point = point_a if target_point == point_b else point_b
	

	rotation += deg_to_rad(rotation_speed * delta)
