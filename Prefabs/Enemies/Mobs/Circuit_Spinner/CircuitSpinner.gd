extends Node2D

export var orientation = "Vertical"
export var speed = 0
export var limitDown = 200
export var limitUp = -200
export var limitLeft = -200
export var limitRight = 200
var direction
var rng



func _ready():
	rng = GameManagerSingleton.rng
	if orientation == "Vertical":
		direction = "Down" if rng.randi_range(0,2) == 1 else "Up"
	if orientation == "Horizontal":
		direction = "Left" if rng.randi_range(0,2) == 1 else "Right"
#	direction = "Up"

func move(delta):
	match(direction):
		"Down":
			$SpinnerArea.position.y += speed * delta
			
		"Up":
			$SpinnerArea.position.y -= speed * delta
		"Left":
			$SpinnerArea.position.x -= speed * delta
		"Right":
			$SpinnerArea.position.x += speed * delta

func check_limit():
	if $SpinnerArea.position.y <= limitUp:
		direction = "Down"
	if $SpinnerArea.position.y >= limitDown:
		direction = "Up"
	if $SpinnerArea.position.x <= limitLeft:
		direction = "Right"
	if $SpinnerArea.position.x >= limitRight:
		direction = "Left"

func Despawn():
	queue_free()

func _physics_process(delta):
	move(delta)
	check_limit()


func _on_SpinnerArea_area_entered(area):
	if area.name == "Player_Hitbox":
		area.hurt()
