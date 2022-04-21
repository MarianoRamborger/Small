extends Node2D

var score = 0

func score_up(x):
	score += x
	get_tree().call_group("Game_UI", "set_score", score)
