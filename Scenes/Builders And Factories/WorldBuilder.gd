extends Node2D

# A Word.
# El visibilizador tendria que arrancar dentro de pantalla.
# Then, al salir, deja de crear.
# Al re-entrar, vuelve a crear so no problem.
onready var Hazards_factory = $Factories/HazardsFactory
onready var Items_factory = $Factories/ItemsFactory
onready var Enemies_factory = $Factories/EnemiesFactory
var Spawners
export var create_at_X = 1225 #First tile shall be created here
export var tile_lenght = 175
var canCreate = true
var tile = load("res://Prefabs/Floors/Basic/BasicFloor.tscn")
var rng = RandomNumberGenerator.new()
var difficulty_level = 1


func _ready():
	pass # Replace with function body.
	rng.randomize()
	Spawners = [Items_factory,Hazards_factory, Enemies_factory] #Add enemies later

func _physics_process(delta):
	if canCreate:
		create_terrain()

func _on_VisibilityNotifier2D_screen_exited():
	canCreate = false

func _on_VisibilityNotifier2D_screen_entered():
	canCreate = true

func increase_difficulty():
	if difficulty_level < 6:
		difficulty_level += 1

func create_terrain():
	
	var newTile = tile.instance()
	newTile.position = Vector2(create_at_X,0)
	get_parent().add_child(newTile)
	
	#NORMAL ROUND
	Spawners[0].spawn(newTile, "Ground")

	var chance = rng.randi_range(0,difficulty_level)

	print(chance)
	if chance == 0:
		Spawners[1].spawn(newTile, "Ground", difficulty_level)
	if chance == 1:
		Spawners[1].spawn(newTile, "Ground", difficulty_level)
	if chance == 2:
		Spawners[1].spawn(newTile,"Air", difficulty_level)
	if chance == 3:
		Spawners[2].spawn(newTile,"Air", difficulty_level)
	if chance == 4:
		Spawners[2].spawn(newTile, "Ground", difficulty_level)
	if chance == 5:
		Spawners[1].spawn(newTile, "Ground", difficulty_level)
		Spawners[2].spawn(newTile,"Air", difficulty_level)
	if chance == 6: 
		Spawners[2].spawn(newTile, "Ground", difficulty_level)
		Spawners[1].spawn(newTile,"Air", difficulty_level)




	create_at_X += tile_lenght
	position.x += tile_lenght



