extends Area2D

onready var parent = get_parent()


func hurt(dmg = 25):
		parent.hp -= dmg
		
func update_fuel(fuel = 25):
		parent.jetpack_stamina += fuel
		if  parent.jetpack_stamina > parent.max_jetpack_stamina:
				parent.jetpack_stamina = parent.max_jetpack_stamina
		elif parent.jetpack_stamina < 0:
			parent.jetpack_stamina = 0
