extends Node2D

enum BLOCK_TYPE { ANY, REST, WARMUP, CHALLENGE , BOSS}
var blocks_since_rest = 3
var warmups_remaining = 10  
var rng
var difficulty = 0
var world_level = -1


#Dentro de un mismo 'Level", la dificultad y velocidad aumentan?
#Then speed baja al principio del nivel siguiente?
var blocks = [
		{
		name = "Basic",
		difficulty = 0,
		type = BLOCK_TYPE.REST,
		repeatable = true,
		floors = 'simple',
		prefab = load("res://Prefabs/Spawnable-Blocks/Level0/Basic.tscn")
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
	if len(blocks) < 3:
		return BLOCK_TYPE.REST
	if (lastBlock["type"] == BLOCK_TYPE.CHALLENGE):
		return BLOCK_TYPE.REST
	elif (warmups_remaining <= 0 and lastBlock["type"] == BLOCK_TYPE.REST):
		warmups_remaining = rng.randi_range(2,7)
		return BLOCK_TYPE.CHALLENGE

	else:
		 return BLOCK_TYPE.REST if rng.randi_range(0,2) == 0 else BLOCK_TYPE.WARMUP
		 




#NEW VERSION
#LA IDEA ES QUE UN TIMER MANEJE EL CAMBIO DE BLOQUES
#DEL MUNDO. HAYA LIKE 4-5 BLOCKS CON SOME DIFFICULTY
#MODIFIERS
#SO FAR:
#0: DESERT, CACTUS Y PIEDRAS
#1: WALL SPIKES, IR RAPIDO

var blocks_rest = [
		{
		name = "Basic",
		difficulty = 0,
		type = BLOCK_TYPE.REST,
		repeatable = true,
		floors = 'simple',
		prefab = load("res://Prefabs/Spawnable-Blocks/Level0/Basic.tscn")
		}
		]
var blocks_desert = [
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
		name = "2Basic+CactusLureTrap",
		difficulty = 0,
		type = BLOCK_TYPE.CHALLENGE,
		repeatable = false,
		floors = 'simple',
		prefab = load("res://Prefabs/Spawnable-Blocks/Level0/Basicx2CactusTrap.tscn")
	},
		{
		name = "Tricactus",
		difficulty = 0,
		type = BLOCK_TYPE.WARMUP,
		repeatable = true,
		prefab = load("res://Prefabs/Spawnable-Blocks/Level0/Tricactus.tscn")
	},
		{
		name = "Cactus challenge",
		difficulty = 0,
		type = BLOCK_TYPE.CHALLENGE,
		repeatable = false,
		prefab = load("res://Prefabs/Spawnable-Blocks/Desert_0/Desert0CactusChallenge.tscn")
	},
			{
		name = "Cactus Platform",
		difficulty = 0,
		type = BLOCK_TYPE.WARMUP,
		repeatable = false,
		prefab = load("res://Prefabs/Spawnable-Blocks/Desert_0/DesertPlatform.tscn")
	},
]

var blocks_spikes = [
	{
		name = "Basic",
		difficulty = 0,
		type = BLOCK_TYPE.REST,
		repeatable = true,
		floors = 'simple',
		prefab = load("res://Prefabs/Spawnable-Blocks/Level0/Basic.tscn")
	},
	{
		name = "Lowest_Spike",
		difficulty = 0,
		type = BLOCK_TYPE.WARMUP,
		repeatable = true,
		floors = 'simple',
		prefab = load("res://Prefabs/Spawnable-Blocks/WallSpike_World/WallSpikeLowest.tscn")
	},
	{
		name = "Second_Lowest_Spike",
		difficulty = 0,
		type = BLOCK_TYPE.WARMUP,
		repeatable = true,
		floors = 'simple',
		prefab = load("res://Prefabs/Spawnable-Blocks/WallSpike_World/SecondLowest.tscn")
	},
		{
		name = "One-n-half-spike",
		difficulty = 0,
		type = BLOCK_TYPE.WARMUP,
		repeatable = true,
		floors = 'simple',
		prefab = load("res://Prefabs/Spawnable-Blocks/WallSpikes_0/ActualSecond.tscn")
	},
		{
		name = "Curve-ball-spike",
		difficulty = 0,
		type = BLOCK_TYPE.WARMUP,
		repeatable = true,
		floors = 'simple',
		prefab = load("res://Prefabs/Spawnable-Blocks/WallSpikes_0/ThirdSpike.tscn")
	},

	{
		name = "DoubleSpike",
		difficulty = 0,
		type = BLOCK_TYPE.WARMUP,
		repeatable = true,
		floors = 'simple',
		prefab = load("res://Prefabs/Spawnable-Blocks/WallSpike_World/Wall_Spike_double_1.tscn")
	},
		{
		name = "Placeholder",
		difficulty = 0,
		type = BLOCK_TYPE.CHALLENGE,
		repeatable = true,
		floors = 'simple',
		prefab = load("res://Prefabs/Spawnable-Blocks/WallSpike_World/Wall_Spike_double_1.tscn")
	},	
]
var blocks_castle = [
	
	{
		name = "Basic",
		difficulty = 0,
		type = BLOCK_TYPE.REST,
		repeatable = true,
		floors = 'simple',
		prefab = load("res://Prefabs/Spawnable-Blocks/Level0/Basic.tscn")
	},
	{
		name = "Spinner",
		difficulty = 0,
		type = BLOCK_TYPE.CHALLENGE,
		repeatable = false,
		floors = 'simple',
		prefab = load("res://Prefabs/Spawnable-Blocks/Castle_0/Basic+Spinner.tscn")
	},
	{
		name = "Spinner Platform",
		difficulty = 0,
		type = BLOCK_TYPE.WARMUP,
		repeatable = false,
		floors = 'simple',
		prefab = load("res://Prefabs/Spawnable-Blocks/Castle_0/DoublePlatformSpinner.tscn")
	},
		{
		name = "Spinner LongJump",
		difficulty = 0,
		type = BLOCK_TYPE.WARMUP,
		repeatable = false,
		floors = 'simple',
		prefab = load("res://Prefabs/Spawnable-Blocks/Castle_0/SpinnerLongjump.tscn")
	},
	{
		name = "Bombardier Fly",
		difficulty = 0,
		type = BLOCK_TYPE.CHALLENGE,
		repeatable = false,
		floors = 'simple',
		prefab = load("res://Prefabs/Spawnable-Blocks/Castle_0/BombardierFly.tscn")
	},
	{
		name = "Castle Spiketrap",
		difficulty = 0,
		type = BLOCK_TYPE.WARMUP,
		repeatable = false,
		floors = 'simple',
		prefab = load("res://Prefabs/Spawnable-Blocks/Castle_0/CastleSpikeTrap.tscn")
	}
	
]

func switch_world_type(world_type):

	match(world_type):
		"Desert":
			blocks = blocks_desert
		"Spikes":
			blocks = blocks_spikes
		"Castle":
			blocks = blocks_castle

