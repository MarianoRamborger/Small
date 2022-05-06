extends KinematicBody2D

export var chained = true
var speed = 0
var gravity = 600
const UP = Vector2(0,-1)




func unchain():
	chained = false
	$Chain.visible = false


func _physics_process(delta):
	if chained:
		move_and_slide(Vector2(speed, 0), UP)
	if is_on_floor():
		speed = 0
	if !chained and !is_on_floor():
		move_and_slide(Vector2(speed, gravity), UP)
		

func _on_Area2D_area_entered(area):
	if chained:
		unchain()
		
		

func _on_WeightArea_area_entered(area):
	if chained:
		unchain()
		get_parent().get_parent().add_child(self)
	if area.name == "Player_Hitbox":
		area.hurt()


func despawn():
	queue_free()


