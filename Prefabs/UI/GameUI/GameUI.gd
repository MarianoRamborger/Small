extends CanvasLayer

var hp = 100
var jStamina = 200
export var maxJStamina = 500

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
