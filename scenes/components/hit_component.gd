class_name HitComponent
extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.revival_of_player()
