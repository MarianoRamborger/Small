extends StaticBody2D

var skin = "Default"

func _ready():
	skin = get_parent().skin
	$AnimatedSprite.play(skin)

func Despawn():
	queue_free()
