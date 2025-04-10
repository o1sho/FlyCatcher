extends Area2D

@export var TileMapLayer_First: TileMapLayer
@export var TileMapLayer_Second: TileMapLayer

@export var hidden_objects: Array[Node] = []
@export var visible_objects: Array[Node] = []

@export var trigger_zone_activation_object: Area2D

@onready var camera: Camera = $"../Camera"
@onready var game_manager: GameManager = $"../GameManager"
@onready var player: Player = $"../Player"

var on_player_entered: bool = false

func _ready() -> void:
	TileMapLayer_First.enabled = true
	TileMapLayer_Second.enabled = false
	player.the_player_has_been_revival.connect(_on_the_player_has_been_revival)

	if hidden_objects.is_empty():
		pass
	else:
		for object in hidden_objects:
			object.visible = false

	if 	trigger_zone_activation_object:
		collision_mask = 0
		game_manager.all_flies_caught.connect(_on_all_flies_caught)
	else:
		return
	
func switch_tilemap_layer():
		if TileMapLayer_First.enabled:	
			TileMapLayer_First.enabled = false
			TileMapLayer_Second.enabled = true
			show_hidden_objects()
			hide_visible_objects()
		else:
			TileMapLayer_First.enabled = true
			TileMapLayer_Second.enabled = false
			hide_hidden_objects()
			show_visible_objects()

func show_hidden_objects() -> void:
	if hidden_objects.is_empty():
		return
	else:
		for object in hidden_objects:
			if object.visible == false:
				object.visible = true

func hide_hidden_objects() -> void:
	if hidden_objects.is_empty():
		return
	else:
		for object in hidden_objects:
			if object.visible == true:
				object.visible = false
				
func hide_visible_objects() -> void:
	if visible_objects.is_empty():
		return
	else:
		for object in visible_objects:
			if object.visible == true:
				object.visible = false
			
func show_visible_objects() -> void:
	if visible_objects.is_empty():
		return
	else:
		for object in visible_objects:
			if object.visible == false:
				object.visible = true
			
			
func _on_body_entered(body: Node2D) -> void:
	#if body.is_in_group("player"):
		#collision_mask = 0
		#switch_tilemap_layer()
		#camera.start_shake()
		#on_player_entered = true
		pass

func _on_all_flies_caught() -> void:
	collision_mask = 2
	pass
	
func _on_the_player_has_been_revival() -> void:
	#collision_mask = 0
	if on_player_entered:
		switch_tilemap_layer()
		on_player_entered = false
		collision_mask = 2
		
	


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		collision_mask = 0
		switch_tilemap_layer()
		AudioPlayer.play_switch_level(4.0, global_position )
		camera.start_shake()
		on_player_entered = true
