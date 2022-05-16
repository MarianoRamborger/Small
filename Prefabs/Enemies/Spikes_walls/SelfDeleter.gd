extends Area2D

func Despawn():
	get_parent().queue_free()
