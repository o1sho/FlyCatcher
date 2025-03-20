class_name Player
extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var game_manager: GameManager = $"../GameManager"
@onready var fat_fly: Sprite2D = $FatFly


@export var speed = 60
@export var fly_velocity = -130.0
@export var rotation_speed = 20

@onready var start_point: Node2D = $"../StartPoint"
@onready var start_nest: Node2D = $"../StartNest"

var block_input_start: bool = true
var block_input_end: bool = false

signal the_player_has_been_revival

func _ready() -> void:
	start_nest.player_in_nest.connect(_on_disable_input)
	global_position = start_point.global_position
	
	fat_fly.visible = false

func _physics_process(delta: float) -> void:
	if block_input_start && !block_input_end:
		var direction := Input.get_axis("ui_left", "ui_right")
		if direction:
			update_rotation(delta, direction)
		
		if Input.is_action_just_pressed("ui_accept") and !fat_fly.visible:
			block_input_start = false
			velocity.y = fly_velocity
			#animated_sprite_2d.play("fly")
		return
	
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	if !block_input_start and !block_input_end:
		if Input.is_action_just_pressed("ui_accept"):
			velocity.y = fly_velocity

		if Input.is_action_just_pressed("ui_accept") and fat_fly.visible:
			velocity.y = fly_velocity / 1.8

		var direction := Input.get_axis("ui_left", "ui_right")
		if direction:
			velocity.x = direction * speed
		else:
			velocity.x = move_toward(velocity.x, 0, speed)
			
		
		if !is_on_floor() and velocity.y < 0:
			animated_sprite_2d.play("fly")
		elif !is_on_floor() and velocity.y > 0:
			animated_sprite_2d.play("fall")
		elif is_on_floor() and velocity.x == 0:
			animated_sprite_2d.play("idle_on_floor")
		elif is_on_floor() and velocity.x != 0:
			animated_sprite_2d.play("move")

		update_rotation(delta, direction)
		move_and_slide()
		
func update_rotation(delta, direction: float):
	var target_rotation = 0.0

	if direction > 0:
		target_rotation = deg_to_rad(10)  # Поворот вправо
	elif direction < 0:
		target_rotation = deg_to_rad(-10)  # Поворот влево
	
	rotation = lerp(rotation, target_rotation, delta * rotation_speed)
	
func revival_of_player() -> void:
	the_player_has_been_revival.emit()
	global_position = start_point.global_position
	block_input_start = true
	print ("Все мухи потеряны!")
	if fat_fly.visible:
		fat_fly.visible = false
	animated_sprite_2d.play("idle")

func _on_disable_input() -> void:
	block_input_end = true
