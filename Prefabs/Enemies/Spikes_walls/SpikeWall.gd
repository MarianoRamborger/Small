extends Node2D

export var pointsDisabled = false

func _ready():
	if pointsDisabled:
		$Wall_area/CollisionShape2D.disabled = true

func _on_Wall_area_area_entered(area):
		if area.name == "Player_Hitbox":
			GameManagerSingleton.score_up(30)
