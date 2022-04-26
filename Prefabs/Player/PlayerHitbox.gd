extends Area2D

onready var parent = get_parent()
onready var playerAnimation = get_parent().get_node("AnimatedSprite/PlayerAnimation")
var invincible = false

func hurt(dmg = 25):
		if !invincible:
			parent.hp -= dmg
			set_invincibility()
			$InvincibilityTimer.start()
			parent.hurting = true
			playerAnimation.play("invincible")
			parent.motion.y = -400
			parent.position.y -= 20
			parent.move_and_slide(parent.motion,parent.UP)
			

func enemy_slain(points = 25):
			parent.motion.y = -300
			parent.position.y -= 20
			parent.move_and_slide(parent.motion,parent.UP)
			get_tree().call_group("GameManager", "score_up", points)
	
		
func update_fuel(fuel = 25):
		parent.jetpack_stamina += fuel
		if  parent.jetpack_stamina > parent.max_jetpack_stamina:
				parent.jetpack_stamina = parent.max_jetpack_stamina
		elif parent.jetpack_stamina < 0:
			parent.jetpack_stamina = 0

func set_invincibility():
	invincible = true

func _on_InvincibilityTimer_timeout():
	playerAnimation.play("default")
	invincible = false
	parent.hurting = false
