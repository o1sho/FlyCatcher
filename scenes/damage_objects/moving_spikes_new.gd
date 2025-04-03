extends Area2D

@export var speed: float = 100
@export var rotation_speed: float = 180
@export var loop_type: int = 0 # 0 - циклический, 1 - пинг-понг, 2 - случайный

@export var path_points_hard: Array[Marker2D] = []
@export var path_points_normal: Array[Marker2D] = []
var current_target_index: int = 0
var moving_forward: bool = true

@export var is_normal_mode: bool = true

func _ready() -> void:	
	# Если нет маркеров - используем текущую позицию как единственную точку
	if path_points_normal.is_empty():
		path_points_normal.append(global_position)
		print("No Marker2D children found! Using self position as single point.")
	
	if path_points_hard.is_empty():
		path_points_hard.append(global_position)
		print("No Marker2D children found! Using self position as single point.")

func _physics_process(delta: float) -> void:
	if path_points_normal.size() == 0:
		rotation += deg_to_rad(rotation_speed * delta)
		return
	
	if is_normal_mode:
		var target_point = path_points_normal[current_target_index].global_position
		global_position = global_position.move_toward(target_point, speed * delta)
	
		if global_position.distance_to(target_point) < 1:
			update_target_index()
	
		rotation += deg_to_rad(rotation_speed * delta)
		
	if !is_normal_mode:
		var target_point = path_points_hard[current_target_index]
		global_position = global_position.move_toward(target_point, speed * delta)
	
		if global_position.distance_to(target_point) < 1:
			update_target_index()
	
		rotation += deg_to_rad(rotation_speed * delta)

func update_target_index():
	match loop_type:
		0: # Циклический режим
			if is_normal_mode: current_target_index = (current_target_index + 1) % path_points_normal.size()
			if !is_normal_mode: current_target_index = (current_target_index + 1) % path_points_hard.size()
		
		1: # Режим пинг-понг
			if is_normal_mode: 
				if moving_forward:
					if current_target_index >= path_points_normal.size() - 1:
						moving_forward = false
						current_target_index -= 1
					else:
						current_target_index += 1
				else:
					if current_target_index <= 0:
						moving_forward = true
						current_target_index += 1
					else:
						current_target_index -= 1
						
			if !is_normal_mode: 
				if moving_forward:
					if current_target_index >= path_points_hard.size() - 1:
						moving_forward = false
						current_target_index -= 1
					else:
						current_target_index += 1
				else:
					if current_target_index <= 0:
						moving_forward = true
						current_target_index += 1
					else:
						current_target_index -= 1
		
		2: # Случайный режим
			if is_normal_mode: current_target_index = randi() % path_points_normal.size()
			if !is_normal_mode: current_target_index = randi() % path_points_hard.size()
