extends Area2D

export var speed = 350

func _physics_process(delta):
	position.x += speed * delta

func _ready():
	pass # Replace with function body.



func _on_EraserArea_area_entered(area):
	if area.has_method("Despawn"):
		area.Despawn



func _on_EraserArea_body_entered(body):
	if body.has_method("Despawn"):
		body.Despawn()
