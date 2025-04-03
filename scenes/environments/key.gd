class_name Key
extends Area2D


signal collected
@onready var game_manager: GameManager = $"../GameManager"
@onready var player: Player = $"../Player"

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_caught()	
		body.key.visible = true

func player_caught() -> void:
	collected.emit()
	visible = false
	set_deferred("monitoring", false)
