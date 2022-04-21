extends Area2D


func _on_Area2D_area_entered(area):
	if area.name == "Player_Hitbox":
		area.get_parent().hurt()
		$PointsArea.monitoring = false


func _on_PointsArea_area_entered(area):
	if area.name == "Player_Hitbox":
		get_tree().call_group("GameManager", "score_up", 20  )
