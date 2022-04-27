extends CanvasLayer

onready var selected = "Start"


func _ready():
	pass # Replace with function body.
	
func _process(delta):
	read_input()
	render_selector()

func render_selector():
	if selected == "Start":
		$Control/ExitContainer/SelectorExit.visible = false
		$Control/StartContainer/SelectorStart.visible = true
	elif selected == "Exit":
		$Control/StartContainer/SelectorStart.visible = false
		$Control/ExitContainer/SelectorExit.visible = true


func read_input():
	if  Input.is_action_just_pressed("Jump") or Input.is_action_just_pressed("Down"):
		if selected == "Start":
			selected = "Exit"
		elif selected == "Exit":
			selected = "Start"
		$MenuMove.play()
	if Input.is_action_just_pressed("Enter") or Input.is_action_just_pressed("Space"):
		if selected == "Start":
			get_tree().change_scene("res://Scenes/Main.tscn")
		elif selected == "Exit":
			get_tree().quit()
