class_name GameManager
extends Node

var flies_for_victory: int = 0
var flies_collected: int = 0

signal first_fly_caught
signal all_flies_caught

var is_fly_caught_first: bool = false

@onready var start_nest: StartNest = $"../StartNest"
@onready var player: Player = $"../Player"
func _ready() -> void:
	player.the_player_has_been_revival.connect(_revival_of_flies)
	
	var flies_at_level = get_tree().get_nodes_in_group("fly").size()
	flies_for_victory = flies_at_level
	print ("Мух на уровне: ", flies_for_victory)


func add_fly() -> void:
	flies_collected += 1
	print ("Мух собрано: ", flies_collected)
	if !is_fly_caught_first:
		is_fly_caught_first = true
		first_fly_caught.emit()
	check_flies()
	
func check_flies() -> void:
	if flies_collected >= flies_for_victory:
		print ("Все мухи собраны!")
		all_flies_caught.emit()
	else:
		print ("Ещё остались мухи...")

func reset_flies() -> void:
	var flies_at_level = get_tree().get_nodes_in_group("fly")
	for fly in flies_at_level:
		fly.visible = true
		fly.set_deferred("monitoring", true)
	flies_collected = 0

func _revival_of_flies() -> void:	
	reset_flies()
