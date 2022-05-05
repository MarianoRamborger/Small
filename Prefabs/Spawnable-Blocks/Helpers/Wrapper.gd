extends Node2D

export var available_positions = PoolVector2Array()

var rng


func _ready():
	rng = get_parent().rng
	if rng and len(available_positions) > 0:
		for child in get_children():
			var offset = available_positions[rng.randi_range(0, len(available_positions) - 1)]
			child.position.x += offset.x
			child.position.y += offset.y



