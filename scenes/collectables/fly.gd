extends Node2D

signal collected
@onready var game_manager: GameManager = $"../GameManager"

func _on_area_2d_body_entered(body: CharacterBody2D) -> void:
	if body.is_in_group("player"):
		collected.emit()
		#var game_manager = get_node("/root/GameManager")
		game_manager.add_fly()
		call_deferred("queue_free")
