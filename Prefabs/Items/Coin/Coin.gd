extends Node2D

export var type = "Bronze"
var points = 25

func _ready():
	pass
	if type == "Silver":
		$CoinArea/Sprite.play("Silver")
		points = 50
	elif type == "Gold":
		$CoinArea/Sprite.play("Gold")
		points = 100
	$AnimationPlayer.play("floating")

func _on_CoinArea_area_entered(area):
		if area.name == "Player_Hitbox":
			get_tree().call_group("GameManager", "score_up", points)
			$AnimationPlayer.play("pick_up")


func Despawn():
	queue_free()
