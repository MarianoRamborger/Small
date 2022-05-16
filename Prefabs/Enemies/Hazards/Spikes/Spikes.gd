extends Node2D

export var xPush = 25
export var yPush = -50

func _on_Area2D_area_entered(area):
		if area.name == "Player_Hitbox":
			area.hurt_and_or_move(xPush, yPush)
