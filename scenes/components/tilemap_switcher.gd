extends Area2D

@export var TileMapLayer_First: TileMapLayer
@export var TileMapLayer_Second: TileMapLayer

@onready var camera: Camera = $"../Camera"

func _ready() -> void:
	TileMapLayer_First.enabled = true
	TileMapLayer_Second.enabled = false

func switch_tilemap_layer():
		if TileMapLayer_First.enabled:	
			TileMapLayer_First.enabled = false
			TileMapLayer_Second.enabled = true
		else:
			TileMapLayer_First.enabled = true
			TileMapLayer_Second.enabled = false


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		switch_tilemap_layer()
		collision_mask = 0
		camera.start_shake()
