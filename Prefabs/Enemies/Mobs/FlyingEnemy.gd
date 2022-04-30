extends KinematicBody2D

export var SPEED = 100
export var GRAVITY = 20
const UP = Vector2(0,-1)
var motion = Vector2(-SPEED,0)
var dead = false
var attackedSuccessfully = false
var on_screen = false


func _ready():
	$AnimatedSprite.play('fly')
	
func _physics_process(delta):
	if on_screen:
		if dead:
			apply_gravity()
		move_and_slide(motion, UP)


func _on_AttackBox_area_entered(area):
		if !dead and area.name == "Player_Hitbox":
			area.hurt(30)
			attackedSuccessfully = true

func _on_DieBox_area_entered(area):
	if !dead and area.name == "Player_Hitbox" and !attackedSuccessfully:
		$AnimatedSprite.play("death")
		dead = true
		area.enemy_slain(30)
		

func apply_gravity():
	motion.y += GRAVITY
	if is_on_floor():
		motion.x = 0


func _on_VisibilityNotifier2D_screen_entered(): 
	on_screen = true


func _on_VisibilityNotifier2D_screen_exited():
	pass
