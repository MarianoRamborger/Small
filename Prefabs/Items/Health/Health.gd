extends Area2D


func play_pickup_animation():
	$AnimationPlayer.play("picked_up")
	
func picked_up():
	queue_free()


func _on_Fuel_Small_area_entered(area):
	if area.name == "Player_Hitbox":
		$FuelUp.play()
		area.heal(30)
		play_pickup_animation()
		get_tree().call_group("GameManager", "score_up", 10)

func Despawn():
	queue_free()
