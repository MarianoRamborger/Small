extends CanvasLayer

var hp = 100
var jStamina = 200
export var maxJStamina = 500
onready var lvlLabel = $Control/VboxStage/LevelLabel

func _ready():
	$Control/VBoxContainer/Health.value = hp
	$Control/VBoxContainer/Jetpack.value = jStamina
	$Control/VBoxContainer/Jetpack.max_value = maxJStamina
	
	

func update_ui(lif, jstam):

	hp = lif
	jStamina = jstam
	$Control/VBoxContainer/Health.value = hp
	$Control/VBoxContainer/Jetpack.value = jStamina
	

func set_score(x):
	$Control/Points.text = str(x)
	
	
#func increase_world_level(worldLevel):
#	lvlLabel.visible = true
#	lvlLabel.text = "LEVEL " + str(worldLevel + 1)
#	$Control/VboxStage/StageLevelTimer.start()
	
func switch_world_type(world_type):
	lvlLabel.visible = true
	lvlLabel.text = world_type + " incoming!"
	$Control/VboxStage/StageLevelTimer.start()


func _on_StageLevelTimer_timeout():
	$Control/VboxStage/AnimationPlayer.play("anounce_level")
	lvlLabel.text = "GET READY"
	$Control/VboxStage/ReadyTimer.start()


func _on_ReadyTimer_timeout():
	lvlLabel.visible = false
