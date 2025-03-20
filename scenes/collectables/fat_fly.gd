extends Fly

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_caught()
		body.fat_fly.visible = true
