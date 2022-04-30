extends Node2D


var fuel = load("res://Prefabs/Items/Fuel/Fuel.tscn")


var rng = RandomNumberGenerator.new()

var tiles_since_last_item = 0

func _ready():
	rng.randomize()


func spawn(newTile, type = "Air"):
	
	#Armar trail
	if true :
		var maybeItem = rng.randi_range(
			1 + tiles_since_last_item, 25)
		if maybeItem > 10:
			tiles_since_last_item = 0
			var newItem = fuel.instance()
			newTile.add_child(newItem)
			newItem.position.y = rng.randi_range(-100,-225)
			newItem.scale.x = 0.8
			newItem.scale.y = 0.8
	else:
		tiles_since_last_item += 1
