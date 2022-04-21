extends Node2D

# A Word.
# El visibilizador tendria que arrancar dentro de pantalla.
# Then, al salir, deja de crear.
# Al re-entrar, vuelve a crear so no problem.


export var create_at_X = 1225 #First tile shall be created here
export var tile_lenght = 175
var canCreate = true
var tile = load("res://Prefabs/Floors/Basic/BasicFloor.tscn")
var rock = load("res://Prefabs/Enemies/Hazards/Rock/Rock.tscn")
var rng = RandomNumberGenerator.new()

var wasLastRock = false

func _ready():
	pass # Replace with function body.
	rng.randomize()


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
	if !wasLastRock :
		var maybeRock = rng.randi_range(1, 20)
		if maybeRock > 10:
			wasLastRock = true
			var newRock = rock.instance()
			newTile.add_child(newRock)
			newRock.position.y -=  48
	else:
		wasLastRock = false
			
	create_at_X += tile_lenght
	position.x += tile_lenght



