extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@export var speed = 60
@export var fly_velocity = -200.0
@export var rotation_speed = 25



func _physics_process(delta: float) -> void:
	if velocity.y > 0:
		animated_sprite_2d.play("fall")
	
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("ui_accept") :
		velocity.y = fly_velocity
		animated_sprite_2d.play("fly")

	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	update_rotation(delta)
	move_and_slide()
	
func update_rotation(delta):
	var target_rotation = 0.0

	if velocity.x > 0:
		target_rotation = deg_to_rad(10)  # Наклон вправо
	elif velocity.x < 0:
		target_rotation = deg_to_rad(-10)  # Наклон влево
	
	rotation = lerp(rotation, target_rotation, delta * rotation_speed)  # Плавный переход
