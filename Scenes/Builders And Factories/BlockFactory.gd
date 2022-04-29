extends Node2D

enum BLOCK_TYPE { ANY, REST, CHALLENGE ,BOSS}
var rng
var blocks = [
	
	{
		name = "Basic",
		difficulty = 0,
		type = BLOCK_TYPE.REST,
		repeatable = true,
		floors = 'simple',
		prefab = load("res://Prefabs/Spawnable-Blocks/1Block/Basic.tscn")
	},
	{
		name = "2Basic+Rock",
		difficulty = 0,
		type = BLOCK_TYPE.CHALLENGE,
		repeatable = false,
		floors = 'simple',
		prefab = load("res://Prefabs/Spawnable-Blocks/2Blocks/2Basic+Cactus.tscn")
	},
	{
		name = "2Basic+Cactus",
		difficulty = 0,
		type = BLOCK_TYPE.CHALLENGE,
		repeatable = false,
		floors = 'simple',
		prefab = load("res://Prefabs/Spawnable-Blocks/2Blocks/2Basic+Rock.tscn")
	},
		{
		name = "DD+CactusRock-Trap",
		difficulty = 1,
		type = BLOCK_TYPE.CHALLENGE,
		repeatable = false,
		floors = 'simple',
		prefab = load("res://Prefabs/Spawnable-Blocks/2Blocks/2DD+CactusRock-Trap.tscn")
	},
	
]

onready var lastBlock = blocks[0]["prefab"]

func _ready():
		pass
		
		

#CAMBIOS
#USAR ARRAY.SHUFFLE Y DESHACERME DEL INDEX. EL RNG RANDOM TENDRIA QUE SER METIDO POR EL PADRE
#PONER EL CAMPO "REPEATABLE" A LOS BLOCKS
func getBlock(difficulty = 1, type = BLOCK_TYPE.ANY, strict_difficulty = false ):
	var index = 0
	var selectedBlock
	while index < len(blocks):
		
		if blocks[index]["type"] == type or type == BLOCK_TYPE.ANY:
			if blocks[index]["difficulty"] == difficulty or (strict_difficulty == false and blocks[index]["difficulty"] < difficulty):
				if blocks[index]["repeatable"] == true or blocks[index]["prefab"] != lastBlock:
					selectedBlock = blocks[index]["prefab"]
					lastBlock = selectedBlock
					break
					
		index += 1
	blocks.shuffle()
	return selectedBlock

