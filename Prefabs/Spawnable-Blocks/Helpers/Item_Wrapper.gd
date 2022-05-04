extends Node2D

export var available_positions = PoolVector2Array()
export var has_random_item = false


#Venue para poder spawnear items al azar, desde la consola.
#Ideally habria que encontrar la forma de poder darle probabilidad distinta a cada item
export var possible_items = [{}]
var rng


func _ready():
	rng = get_parent().rng
	if rng and len(available_positions) > 0:
		
		#Well, basically sortea el array para tener la chance de mayor valor (no necesariamente la chance mas alta) al final
		#Then, decide al azar entre 0, prob mas alta
		#Then, itera el array de objetos y, al encontrar uno mayor que la chance, gets it.

		if has_random_item:
				possible_items.sort_custom(ProbabilitySorter, "sort")
				var last_item = possible_items[len(possible_items) - 1]
				var maximum_probability = last_item["Probability"]
				var probability = rng.randi_range(0, maximum_probability)
				for item in possible_items:
					if item["Probability"] > probability:
						var newItem = item["Item"].instance()
						add_child(newItem)
						return
					
		
		for child in get_children():
			var offset = available_positions[rng.randi_range(0, len(available_positions) - 1)]
			child.position.x += offset.x
			child.position.y += offset.y



class ProbabilitySorter:
	static func sort(a,b):
		if a["Probability"] < b["Probability"]:
			return true
		return false
