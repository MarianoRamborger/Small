extends Node2D

var score = 0
var next_level = 100
var muteSound = false

func score_up(x):
	score += x
	get_tree().call_group("Game_UI", "set_score", score)
	if score >= next_level:
		next_level = next_level * 3
		get_tree().call_group("Difficulty", "increase_difficulty")


func _process(delta):
	if Input.is_action_just_released("Mute_Music"):
		if !muteSound:
			print("FF")
			AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), -100)
			muteSound = true
		else:
			AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), 1)
			muteSound = false


