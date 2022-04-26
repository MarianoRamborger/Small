extends Node2D

var score = 0
var next_level = 100

func score_up(x):
	score += x
	get_tree().call_group("Game_UI", "set_score", score)
	if score >= next_level:
		next_level = next_level * 3
		get_tree().call_group("Difficulty", "increase_difficulty")
