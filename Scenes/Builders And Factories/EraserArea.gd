extends Area2D

export var speed = 1000
var canAdvance = true

func _physics_process(delta):
	if canAdvance:
		position.x += speed * delta


func _ready():
	pass # Replace with function body.



func _on_EraserArea_area_entered(area):
	
	if area.has_method("Despawn"):
		area.Despawn()
	elif area.get_parent().has_method("Despawn"):
		area.get_parent().has_method.despawn()



func _on_EraserArea_body_entered(body):
	if body.has_method("Despawn"):
		body.Despawn()


func _on_VisibilityNotifier2D_screen_entered():
	canAdvance = false


func _on_VisibilityNotifier2D_screen_exited():
	canAdvance = true
