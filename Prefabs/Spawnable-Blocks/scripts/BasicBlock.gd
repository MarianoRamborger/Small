extends Node2D

# Ability to randomize the position of the hazard in the tile.
export var hazard0RandomizerX = 30
export var hazard0RandomizerY = 0
export var difficulty_rating = 0
export var total_lenght = 175 #El default

export var enemy0RandomizerX = 30
export var enemy0RandomizerY = 1
var rng
export var hasHazard0 = false
export var hasEnemy0 = false


func _ready():
	if rng and hasHazard0:
		var haz0 = $Hazard0
		var haz0x = rng.randi_range(-hazard0RandomizerX,hazard0RandomizerX)
		$Hazard0.position.x += haz0x
	if rng and hasEnemy0:
		var ene0 = $Enemy0
		var ene0x = rng.randi_range(-enemy0RandomizerX,enemy0RandomizerX)
		var ene0y = rng.randi_range(-enemy0RandomizerY,enemy0RandomizerY)
		$Enemy0.position.x += ene0x
		$Enemy0.position.y += ene0y

