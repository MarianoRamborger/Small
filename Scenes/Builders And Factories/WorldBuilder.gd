extends Node2D

# A Word.
# El visibilizador tendria que arrancar dentro de pantalla.
# Then, al salir, deja de crear.
# Al re-entrar, vuelve a crear so no problem.
onready var Hazards_factory = $Factories/HazardsFactory
onready var Items_factory = $Factories/ItemsFactory
var Spawners
export var create_at_X = 1225 #First tile shall be created here
export var tile_lenght = 175
var canCreate = true
var tile = load("res://Prefabs/Floors/Basic/BasicFloor.tscn")

var rng = RandomNumberGenerator.new()

var wasLastRock = false

func _ready():
	pass # Replace with function body.
	rng.randomize()
	Spawners = [Hazards_factory, Items_factory] #Add enemies later

func _physics_process(delta):
	if canCreate:
		create_terrain()

func _on_VisibilityNotifier2D_screen_exited():
	canCreate = false

func _on_VisibilityNotifier2D_screen_entered():
	canCreate = true



func create_terrain():
	
	var newTile = tile.instance()
	newTile.position = Vector2(create_at_X,0)
	get_parent().add_child(newTile)
	
	# SWITCH THIS TO RNG
	# Spawn at ground
	Spawners[0].spawn(newTile, "Ground")
	# Spawn on air
	Spawners[1].spawn(newTile, "Air")

	create_at_X += tile_lenght
	position.x += tile_lenght



