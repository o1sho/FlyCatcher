extends Area2D

signal collected
@onready var game_manager: GameManager = $"../GameManager"

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		collected.emit()
		game_manager.add_fly()
		#call_deferred("queue_free")
		visible = false
		set_deferred("monitoring", false)
