extends KinematicBody2D

export var SPEED = 225
const UP = Vector2(0,-1)
var motion = Vector2(-50,50)
export var directionType = "horizontal"
var currentDirection = "left"
var ticks_remaining = 400
var enraging = false
var chase_speed = 0
export var points = 45
var dead = false

func _ready():
	$AnimatedSprite.play("slow_spin")

func _physics_process(delta):
	if !dead:
		move_and_slide(motion, UP)

func _on_HurtBox_area_entered(area):
	if area.name == "Player_Hitbox" and ! dead:
		area.hurt(25)
		$PointsDetector/CollisionShape2D.disabled = true


func _on_DetectionBox_area_entered(area):
	if area.name == "Player_Hitbox" and !enraging and !dead:
		enraging = true
		chase_speed = area.get_parent().SPEED 
		motion.x = chase_speed +  200
		$AnimationPlayer.play("Enraged")

func shoot():
	motion.x = chase_speed + 1000
	$AnimationPlayer.play("Chase")


func _on_PointsDetector_area_entered(area):
	if area.name == "Player_Hitbox":
		get_tree().call_group("GameManager", "score_up", points)

func die():

	motion.x = 0
	dead = true
	enraging = false
	Despawn()

func Despawn():
	print("DIE")
	queue_free()
