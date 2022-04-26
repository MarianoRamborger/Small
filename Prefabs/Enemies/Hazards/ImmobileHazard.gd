extends Area2D

export var points = 20

func _on_Area2D_area_entered(area):
	if area.name == "Player_Hitbox":
		area.hurt()
		$PointsArea.monitoring = false


func _on_PointsArea_area_entered(area):
	if area.name == "Player_Hitbox":
		get_tree().call_group("GameManager", "score_up", points  )

func Despawn():
	queue_free()
