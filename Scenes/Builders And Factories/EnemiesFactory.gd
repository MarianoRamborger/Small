extends Node2D


var rng = RandomNumberGenerator.new()

var ground_enemies = {
	frog = {
		prefab = load("res://Prefabs/Enemies/Mobs/Frog/Frog.tscn"),
		posX = 0, posY = 45, scale = 0.5
	},
}

var air_enemies =  {
	fly = {
		prefab = load("res://Prefabs/Enemies/Mobs/Fly/Fly.tscn"),
		posX = 0, posY = 120, scale = 0.5
	}
}


var tiles_since_last_enemy = 0

func _ready():
	rng.randomize()

func spawn(newTile, type = "Ground", difficulty_level = 0):
	if tiles_since_last_enemy > 0 :
		var maybeEnemy = rng.randi_range(
			1 + tiles_since_last_enemy + difficulty_level, 40)
		if maybeEnemy > 30:
			tiles_since_last_enemy = 0
			var newEnemy
			var newEnemyInstance
			if type == "Ground":
				newEnemy = ground_enemies[ground_enemies.keys()[rng.randi_range(0,len(ground_enemies) - 1)]]
			else:
				newEnemy = air_enemies[air_enemies.keys()[rng.randi_range(0,len(air_enemies) - 1)]]
			newEnemyInstance = newEnemy.prefab.instance()
			newTile.add_child(newEnemyInstance)
			
			newEnemyInstance.position.y -= newEnemy.posY if type == "Ground" else rng.randi_range(newEnemy.posY + 30, newEnemy.posY - 30)
			newEnemyInstance.position.x += rng.randi_range(-15,15)
			newEnemyInstance.scale.x = newEnemy.scale
			newEnemyInstance.scale.y = newEnemy.scale
	else:
		tiles_since_last_enemy += 1

	


