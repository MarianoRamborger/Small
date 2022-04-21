extends StaticBody2D


func _ready():
	pass # Replace with function body.


func Despawn():
	print("Despawning")
	queue_free()
