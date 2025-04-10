extends Button

@onready var sprite_2d: Sprite2D = $Sprite2D

func _ready():
	button_pressed = Data.is_sound_enabled
	pressed.connect(_on_toggled)
	
	call_deferred("update_sprite")

func _on_toggled():
	Data.toggle_sound()

	if Data.is_sound_enabled:
		sprite_2d.frame = 0
	else: sprite_2d.frame = 1

func update_sprite():
	if Data.is_sound_enabled:
		sprite_2d.frame = 0
	else: sprite_2d.frame = 1
