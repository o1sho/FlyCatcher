extends Area2D

@export var point_a: Vector2 
@export var point_b: Vector2
@export var point_c_additional: Vector2
@export var speed: float = 100
@export var rotation_speed: float = 180

@export var not_move: bool = false
@export var three_point_mode: bool = false

var target_point: Vector2

var dir: int = 1

func _ready() -> void:
	target_point = point_a
	
	if not_move:
		point_a = global_position
		point_b = global_position
		point_c_additional = global_position
		speed = 0

func _physics_process(delta: float) -> void:
	global_position = global_position.move_toward(target_point, speed * delta)

	if !three_point_mode:
		if global_position.distance_to(target_point) < 1:
			target_point = point_a if target_point == point_b else point_b
	else: 
		if global_position.distance_to(target_point) < 1:
			print (dir)
			match target_point:
				point_a:
					target_point = point_b
					dir = 1
				point_b:
					if dir == 1:	
						target_point = point_c_additional
						dir = 1
					if dir == -1:
						target_point = point_a
				point_c_additional:
					dir = -1
					target_point = point_b
	
	rotation += deg_to_rad(rotation_speed * delta)
