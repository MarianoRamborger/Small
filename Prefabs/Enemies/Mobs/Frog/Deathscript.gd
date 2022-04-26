extends Area2D


func Despawn():
	print("should despawn")
	get_parent().get_parent().queue_free()
