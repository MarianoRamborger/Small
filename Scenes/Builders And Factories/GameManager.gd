extends Node2D

var score = 0
var world_level = -1
var next_level = 250
var muteSound = false

func score_up(x):
	score += x
	get_tree().call_group("Game_UI", "set_score", score)
	if score >= next_level:
		next_level = next_level * 2
		get_tree().call_group("Difficulty", "increase_difficulty")

#Este solo subiria matando bosses o pasando eventos
func world_level_up():
	world_level += 1
	get_tree().call_group("World_Level", "increase_world_level", world_level)

func _process(delta):
	if Input.is_action_just_released("Mute_Music"):
		if !muteSound:
			AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), -100)
			muteSound = true
		else:
			AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), 1)
			muteSound = false


func _on_Level0_Timer_timeout():
	world_level_up()
