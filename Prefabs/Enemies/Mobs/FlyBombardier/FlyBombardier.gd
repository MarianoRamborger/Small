extends "res://Prefabs/Enemies/Mobs/FlyingEnemy.gd"

var rng
var has_chain = true

func _ready():
		rng = RngSingleton.rng
		var relocateRaycast = rng.randi_range(500, 1000)
		$WeightRaycast/WRayShape.position.x -= 500


func _on_VisibilityNotifier2D_screen_entered():
	on_screen = true
	get_node("../Weight/WeightBody").speed = -100


func _on_WeightRaycast_area_entered(area):
	if area.name == "Player_Hitbox" and has_chain:
		get_node("../Weight/WeightBody").unchain()
