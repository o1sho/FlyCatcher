extends Node2D

var ready_to_finish: bool = false

@export var delay_for_finish: int = 2

@onready var game_manager: GameManager = $"../GameManager"

signal player_in_nest

func _ready() -> void:
	game_manager.all_flies_caught.connect(_on_game_manager_all_flies_caught)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and ready_to_finish:
		print("player in nest")
		player_in_nest.emit()
		get_parent().get_next_level()
		await get_tree().create_timer(delay_for_finish).timeout
		get_parent().finish_level()
		

func _on_game_manager_all_flies_caught() -> void:
	ready_to_finish = true
	print ("all flies caught")
