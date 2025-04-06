extends Control

var progress = []
var next_scene_path
var scene_load_status = 0

func _ready() -> void:
	next_scene_path = "res://scenes/levels/level_%d.tscn" % Data.current_level
	ResourceLoader.load_threaded_request(next_scene_path)
	
func _process(delta: float) -> void:
	scene_load_status = ResourceLoader.load_threaded_get_status(next_scene_path, progress)
	var progres_status = int(floor(progress[0]*100))

	if scene_load_status == ResourceLoader.THREAD_LOAD_LOADED:
		var new_scene = ResourceLoader.load_threaded_get(next_scene_path)
		get_tree().change_scene_to_packed(new_scene)
