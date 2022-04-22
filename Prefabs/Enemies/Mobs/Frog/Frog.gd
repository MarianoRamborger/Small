extends Node2D

export var SPEED = 300
export var jump_height = -300
export var GRAVITY = 20
const UP = Vector2(0,-1)
var motion = Vector2(-SPEED,0)
var attacking = false

func _on_AttackTimer_timeout():
	print("ATTACK")
	$AttackBody/CollisionPolygon2D.disabled = false
	$AttackBody/AttackBox.monitoring = true
#	$AttackBody/DieBox.monitoring = true
	$AttackBody/AnimatedSprite.play("leap")
	attacking = true
	position.y -= 50
	motion.y = jump_height
	

func _physics_process(delta):
	if (attacking):
		$AttackBody.move_and_slide(motion, UP)
	apply_gravity()
	

func apply_gravity():
		if not $AttackBody.is_on_floor():
			motion.y += GRAVITY
		elif attacking:
			motion.y = GRAVITY
			$AttackBody/AnimatedSprite.play("default")
			$AttackTimer.start()
			attacking = false
			$AttackBody/CollisionPolygon2D.disabled = true
			$AttackBody/AttackBox.monitoring = false
#			$AttackBody/DieBox.monitoring = false




func _on_AttackBox_area_entered(area):
	if area.name == "Player_Hitbox":
		area.hurt(40)


func _on_DieBox_area_entered(area):
	pass
