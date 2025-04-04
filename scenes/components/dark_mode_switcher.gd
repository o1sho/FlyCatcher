extends Area2D

var is_darkened: bool = false
@onready var player: Player = $"../Player"
@onready var dark: Sprite2D = $"../Player/Dark"

var on_player_entered: bool = false

func _ready() -> void:
	player.the_player_has_been_revival.connect(_on_the_player_has_been_revival)
	dark.visible = false

func _on_body_exited(body: Node2D) -> void:
	on_player_entered = true
	switch_dark_mode()
	collision_mask = 0
	
func _on_the_player_has_been_revival() -> void:
	#collision_mask = 0
	if on_player_entered:
		switch_dark_mode()
		on_player_entered = false
		collision_mask = 2

func switch_dark_mode():
	if !is_darkened:
		is_darkened = true
		dark.visible = true
		return
	elif is_darkened:
		is_darkened = false
		dark.visible = false
		return
