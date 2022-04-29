extends Area2D



func _on_Area2D_area_entered(area):
		if area.name == "Player_Hitbox":
			area.hurt_and_or_move(25,-400)
