extends Node2D

# General Idea
# Same as old world builder but, instead of having a hazard and enemy builder,
# It should spawn set pieces by block, o sea combos of enemy/hazard or even
# none. Con cierta variacion de spawn de los mismos.

#Also, las gemas should spawn sin set pieces mostly, o con cierta independencia.
#Remember to spawn them via trail

#What si hiciera los bloques con el editor?
#Y randomizara a bit el posicionamiento de la stuff
#Then llamo el prefab desde el editor?



# A Word.
# El visibilizador tendria que arrancar dentro de pantalla.
# Then, al salir, deja de crear.
# Al re-entrar, vuelve a crear so no problem.
#onready var Hazards_factory = $Factories/HazardsFactory
onready var Items_factory = $Factories/ItemsFactory
#onready var Enemies_factory = $Factories/EnemiesFactory
onready var Block_factory = $Factories/BlocksFactory
var Spawners
export var create_at_X = 1225 #First tile shall be created here
export var tile_lenght = 175
var canCreate = true
#var tile = load("res://Prefabs/Floors/Basic/BasicFloor.tscn")
#var tile = load("res://Prefabs/Spawnable-Blocks/Basic.tscn")
var rng
var difficulty_level = 1
var world_level = -1
var skin = "Default"



func _ready():
	rng = RngSingleton.rng
	Block_factory.rng = rng
	Spawners = [Items_factory] 

func _physics_process(delta):
	if canCreate:
		create_terrain()

func _on_VisibilityNotifier2D_screen_exited():
	canCreate = false

func _on_VisibilityNotifier2D_screen_entered():
	canCreate = true

func increase_difficulty():
		difficulty_level += 1
		

func increase_world_level(worldLevel):
	world_level = worldLevel

func switch_world_type(world_type):
	skin = world_type

func create_terrain():
	var tile = Block_factory.getBlock()
	var newTile = tile.instance()
	newTile.rng = rng
	newTile.skin = skin
	newTile.position = Vector2(create_at_X,0)
	get_parent().add_child(newTile)
	

	var chance = clamp(rng.randi_range(0,difficulty_level), 0, 6)
	

	create_at_X += newTile.total_lenght
	position.x += newTile.total_lenght



