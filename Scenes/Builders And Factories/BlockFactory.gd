extends Node2D

enum BLOCK_TYPE { ANY, REST, WARMUP, CHALLENGE , BOSS}
var blocks_since_rest = 3
var warmups_remaining = 10  
var rng
var difficulty = 0
var blocks = [
	{
		name = "Basic",
		difficulty = 0,
		type = BLOCK_TYPE.REST,
		repeatable = true,
		floors = 'simple',
		prefab = load("res://Prefabs/Spawnable-Blocks/Level0/Basic.tscn")
	},
	{
		name = "2Basic+Rock",
		difficulty = 0,
		type = BLOCK_TYPE.WARMUP,
		repeatable = false,
		floors = 'simple',
		prefab = load("res://Prefabs/Spawnable-Blocks/Level0/2Basic+Rock.tscn")
	},
	{
		name = "2Basic+Cactus",
		difficulty = 0,
		type = BLOCK_TYPE.WARMUP,
		repeatable = false,
		floors = 'simple',
		prefab = load("res://Prefabs/Spawnable-Blocks/Level0/2Basic+Cactus.tscn")
	},
		{
		name = "PLACEHOLDERLVL0CHALLENGE",
		difficulty = 0,
		type = BLOCK_TYPE.CHALLENGE,
		repeatable = false,
		floors = 'simple',
		prefab = load("res://Prefabs/Spawnable-Blocks/Level0/2Basic+Rock.tscn")
	},
]

var lvl1Blocks = [
			{
		name = "Basic4WaySpiketrap",
		difficulty = 1,
		type = BLOCK_TYPE.CHALLENGE,
		repeatable = false,
		floors = 'simple',
		prefab = load("res://Prefabs/Spawnable-Blocks/Level1/Basic+4waytrap.tscn")
	},
	{
		name = "2Basic+SpikeTrap",
		difficulty = 1,
		type = BLOCK_TYPE.WARMUP,
		repeatable = true,
		floors = 'simple',
		prefab = load("res://Prefabs/Spawnable-Blocks/Level1/2Basic+SpikeTrap.tscn")
	},
]

var lvl2Blocks = [
	{
		name = "Basic+Spinner",
		difficulty = 2,
		type = BLOCK_TYPE.WARMUP,
		repeatable = false,
		floors = 'simple',
		prefab = load("res://Prefabs/Spawnable-Blocks/Level2/Basic+Spinner.tscn")
	},
	{
		name = "DD+CactusRock-Trap",
		difficulty = 2,
		type = BLOCK_TYPE.CHALLENGE,
		repeatable = false,
		floors = 'simple',
		prefab = load("res://Prefabs/Spawnable-Blocks/Level3/Basic+3Flyers.tscn")
	},
]

var lvl3Blocks = [
	{
		name = "Basic+3Flyers",
		difficulty = 3,
		type = BLOCK_TYPE.CHALLENGE,
		repeatable = false,
		floors = 'simple',
		prefab = load("res://Prefabs/Spawnable-Blocks/1Block/Basic+3Flyers.tscn")
	},
]

onready var lastBlock = blocks[0]

func _ready():
		pass
		
		

#CAMBIOS
#USAR ARRAY.SHUFFLE Y DESHACERME DEL INDEX. EL RNG RANDOM TENDRIA QUE SER METIDO POR EL PADRE
#PONER EL CAMPO "REPEATABLE" A LOS BLOCKS
func getBlock(strict_difficulty = false ):
	var type = pick_next_block_type()
	var index = 0
	var selectedBlock
	while index < len(blocks):
		
		if blocks[index]["type"] == type or type == BLOCK_TYPE.ANY:
			if blocks[index]["difficulty"] == difficulty or (strict_difficulty == false and blocks[index]["difficulty"] < difficulty):
				if blocks[index]["repeatable"] == true or blocks[index]["prefab"] != lastBlock["prefab"]:
					selectedBlock = blocks[index]
					lastBlock = selectedBlock
					
					if selectedBlock["type"] == BLOCK_TYPE.WARMUP:
						warmups_remaining -= 1
					
					break
					
		index += 1
	blocks.shuffle()
	return selectedBlock["prefab"]


func pick_next_block_type():

	if (lastBlock["type"] == BLOCK_TYPE.CHALLENGE):
		return BLOCK_TYPE.REST
	elif (warmups_remaining <= 0 and lastBlock["type"] == BLOCK_TYPE.REST):
		warmups_remaining = rng.randi_range(2,7)
		return BLOCK_TYPE.CHALLENGE

	else:
		 return BLOCK_TYPE.REST if rng.randi_range(0,1) == 0 else BLOCK_TYPE.WARMUP
		 


func increase_difficulty():
	difficulty += 1
	if difficulty == 1:
		blocks.append_array(lvl1Blocks)
		
#	if difficulty == 2:
#		blocks.append_array(lvl2Blocks)
#	if difficulty == 3:
#		blocks.append_array(lvl3Blocks)

