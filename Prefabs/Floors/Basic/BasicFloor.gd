extends StaticBody2D


var skin = "Default"

func _ready():
	pass # Replace with function body.
	skin = get_parent().skin 
	$Sprite.play(skin)

func Despawn():
	queue_free()
