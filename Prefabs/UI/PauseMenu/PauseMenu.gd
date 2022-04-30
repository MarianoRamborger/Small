extends CanvasLayer

var paused = false

func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS

func _process(delta):
	check_pause()

func check_pause():
	
	if Input.is_action_just_pressed("Pause"):
		if !paused:
			get_tree().paused = true
			$Control.visible = true
			paused = true
		else:
			get_tree().paused = false
			$Control.visible = false
			paused = false
