extends Node2D

var score = 0
var difficulty_factor = 0
var muteSound = false
var world_level = 0
var next_level = 250
var rng
var world_types = ["Desert", "Spikes", "Castle"]
var current_world_type = 0
var first_time = true


func _ready():
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), -100)
	muteSound = true
	rng = RngSingleton.rng

func score_up(points):
	score += points
	get_tree().call_group("Game_UI", "set_score", score)
	if score >= next_level:
		next_level = next_level * 2
		get_tree().call_group("Difficulty", "increase_difficulty")


func _process(delta):
	if Input.is_action_just_released("Mute_Music"):
		if !muteSound:
			AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), -100)
			muteSound = true
		else:
			AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), 1)
			muteSound = false


func _on_StartTimer_timeout():
	if !first_time:
		world_types.shuffle()
	get_tree().call_group("World_Type", "switch_world_type", world_types[0])
	$ChangeWorldTimer.start()
	

func _on_ChangeWorldTimer_timeout():
	if current_world_type == len(world_types) -1:
		first_time = false
		world_level += 1
		get_tree().call_group('World_Level',"increase_world_level", world_level)
		current_world_type = 0
		world_types.shuffle()
	else:
		current_world_type += 1
	get_tree().call_group("World_Type", "switch_world_type", world_types[current_world_type])
	$ChangeWorldTimer.start()
