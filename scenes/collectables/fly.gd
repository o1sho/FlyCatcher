class_name Fly
extends Area2D

signal collected
@onready var game_manager: GameManager = $"../GameManager"

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_caught()

func player_caught() -> void:
	collected.emit()
	game_manager.add_fly()
	visible = false
	set_deferred("monitoring", false)
