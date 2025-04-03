extends Area2D

@onready var animation_gate: AnimationPlayer = $AnimationGate

@onready var static_body_2d: StaticBody2D = $StaticBody2D
@onready var sprite_2d: Sprite2D = $Sprite2D

func  _ready() -> void:
	sprite_2d.frame = 0

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if body.key.visible:
			animation_gate.play("open")
			#await animation_gate.animation_finished
			body.key.visible = false
		else:
			return
