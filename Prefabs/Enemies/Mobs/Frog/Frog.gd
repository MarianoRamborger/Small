extends Node2D

export var SPEED = 300
export var jump_height = -300
export var GRAVITY = 20
const UP = Vector2(0,-1)
var motion = Vector2(-SPEED,0)
var attacking = false
var dead = false
var attackedSuccessfully = false

func _on_AttackTimer_timeout():
	if !dead :
		attackedSuccessfully = false
		$AttackBody/AttackBox.monitoring = true
		$AttackBody/AnimatedSprite.play("leap")
		attacking = true
		position.y -= 50
		motion.y = jump_height
	

func _physics_process(delta):
	if attacking:
		$AttackBody.move_and_slide(motion, UP)
	apply_gravity()
	

func apply_gravity():
		if dead and not $AttackBody.is_on_floor():
			motion.y += GRAVITY
		if not $AttackBody.is_on_floor():
			motion.y += GRAVITY
		elif attacking:
			motion.y = GRAVITY
			$AttackBody/AnimatedSprite.play("default")
			$AttackTimer.start()
			attacking = false
			$AttackBody/AttackBox.monitoring = false




func _on_DieBox_area_entered(area):
	if !dead and area.name == "Player_Hitbox" and !attackedSuccessfully:
		$AnimationPlayer.play("death")
		dead = true
		area.enemy_slain(30)


func _on_AttackBox_area_entered(area):
	if !dead and area.name == "Player_Hitbox":
		area.hurt(25)
		attackedSuccessfully = true



	
func Despawn():
	get_parent().queue_free()
