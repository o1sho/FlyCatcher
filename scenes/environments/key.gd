class_name Key
extends Area2D


signal collected
@onready var game_manager: GameManager = $"../GameManager"
@onready var player: Player = $"../Player"

func _ready() -> void:
	player.the_player_has_been_revival.connect(_on_the_player_has_been_revival)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_caught()	
		body.key.visible = true

func player_caught() -> void:
	collected.emit()
	visible = false
	AudioPlayer.play_catch(0.0, global_position)
	set_deferred("monitoring", false)
	
func player_revival() -> void:
	visible = true
	set_deferred("monitoring", true)

func _on_the_player_has_been_revival() -> void:
	player_revival()
