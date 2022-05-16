extends Node2D

#var score = 0
#var world_level = -1
#var next_level = 250
#var muteSound = false
#
#func score_up(x):
#	GameManagerSingleton.score_up(x) #Temporal 
#	#Hasta que haga que todo apunte al singleton gamemanager
#
#func world_level_up():
#	world_level += 1
#	get_tree().call_group("World_Level", "increase_world_level", world_level)
#
#func _process(delta):
#	if Input.is_action_just_released("Mute_Music"):
#		if !muteSound:
#			AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), -100)
#			muteSound = true
#		else:
#			AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), 1)
#			muteSound = false
#
#
#func _on_Level0_Timer_timeout():
#	world_level_up()
