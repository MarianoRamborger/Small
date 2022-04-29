extends Node2D

# Ability to randomize the position of the hazard in the tile.
export var hazard0RandomizerX = 30
export var hazard0RandomizerY = 0
export var difficulty_rating = 0
export var total_lenght = 175 #El default
var rng




onready var haz0 = $Hazard0

func _ready():
	if rng and haz0:
		var haz0x = rng.randi_range(-hazard0RandomizerX,hazard0RandomizerX)
		$Hazard0.position.x += haz0x


