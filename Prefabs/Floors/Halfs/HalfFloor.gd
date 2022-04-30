extends StaticBody2D

export var type = "mid"

func _ready():
	if type == "mid":
		$AnimatedSprite.play("Mid")
	elif type == "left":
		$AnimatedSprite.play("Left")
	elif type == "right":
		$AnimatedSprite.play('Right')

func Despawn():
	queue_free()
