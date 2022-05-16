extends Node2D

var rng
var active = false
var jumping = false
var prepping = false
const GRAVITY = 20
const UP = Vector2(0,-1)
var motion = Vector2(0,0)
export var jump_speed = -800
export var walk_speed = 0

func _ready():
	rng = RngSingleton.rng
	$PrepTimer.wait_time = rng.randf_range(0.3, 0.6)
	$JumpTimer.wait_time = rng.randf_range(0.6, 1.2)

func _physics_process(delta):
		if $SlimeBody.is_on_floor():
			jumping = false
			motion.y -= GRAVITY
			if !prepping:
				prepping = true
				$PrepTimer.start()
			else:
				motion.x = 0
		else:
			motion.y += GRAVITY 
							
		$SlimeBody.move_and_slide(motion, UP)

		


func _on_VisibilityNotifier2D_screen_entered():
	active = true
	$PrepTimer.start()
	

func _on_Timer_timeout():

	$AnimationPlayer.play("Preparing")
	$JumpTimer.start()



func _on_JumpTimer_timeout():
		print("JUMP TIMER TIMEOUT")
		print("Slime not on floor")
		$AnimationPlayer.play("Default")
		position.y -= 20
		jumping = true
		motion.y = jump_speed
		motion.x = walk_speed
		prepping = false

