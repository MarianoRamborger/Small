extends Node2D

export var enemyPos = PoolVector2Array()

func _ready():
	var rng = get_parent().rng
	var index = 0
	for children in get_children():
		children.position.x += rng.randi_range(-enemyPos[index].x, enemyPos[index].x) 
		children.position.y += rng.randi_range(-enemyPos[index].y, enemyPos[index].y) 
		index += 1
	
	
	
