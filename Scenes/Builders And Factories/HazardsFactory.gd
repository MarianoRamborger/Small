extends Node2D

var rock = load("res://Prefabs/Enemies/Hazards/Rock/Rock.tscn")
var rng = RandomNumberGenerator.new()

var ground_hazards = {
	rock = {
		prefab = load("res://Prefabs/Enemies/Hazards/Rock/Rock.tscn"),
		posX = 0, posY = 48
	},
	cactus = {
		prefab = load("res://Prefabs/Enemies/Hazards/Cactus/Cactus.tscn"),
		posX = 0, posY = 48 
	}
}





var tiles_since_last_hazard = 0

func _ready():
	rng.randomize()


func spawn(newTile, type = "Ground", difficulty_level = 0):
	if tiles_since_last_hazard > 0 :
		var maybeHazard = rng.randi_range(
			1 + tiles_since_last_hazard + difficulty_level , 25)
		if maybeHazard > 10:
			tiles_since_last_hazard = 0
			var newHazard
			var newHazardInstance
			if type == "Ground":
				newHazard = ground_hazards[ground_hazards.keys()[rng.randi_range(0,len(ground_hazards) - 1)]]
			else :
				newHazard = ground_hazards[ground_hazards.keys()[rng.randi_range(0,len(ground_hazards) - 1)]]
			newHazardInstance = newHazard.prefab.instance()
			newTile.add_child(newHazardInstance)
			newHazardInstance.position.y -=  newHazard.posY
			newHazardInstance.position.x += rng.randi_range(-15,15)
	else:
		tiles_since_last_hazard += 1
