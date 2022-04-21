extends KinematicBody2D

export var SPEED = 300
export var GRAVITY = 20
const WORLD_LIMIT = 10000 #BAJAR
const UP = Vector2(0,-1)
var motion = Vector2(SPEED,0)


export var hp = 100
export var jump_speed = 50
export var jump_stamina = 75
export var max_jump_stamina = 75

export var jetpack_stamina = 500
export var max_jetpack_stamina = 500
var falling =  false
var canJump = false
var jumping = false

func _ready():
	$AnimatedSprite.play('default')

	
func _physics_process(delta):
	motion.x = SPEED
	apply_gravity()
	handle_movement()
	jump()
	animate()
	move_and_slide(motion, UP)
	on_floor_collision()
	get_tree().call_group("Game_UI", "update_ui", hp, jetpack_stamina)
	enforce_max_height()



func apply_gravity():
#	if !jumping:
		if !is_on_floor():
			motion.y += GRAVITY
		else:
			motion.y = GRAVITY
			

func animate():
	if is_on_floor():
		$AnimatedSprite.play('run')

func handle_movement():
	move_and_slide(motion, UP)
	
func on_floor_collision():
	if is_on_floor():
		jump_stamina = max_jump_stamina
#		jetpack_stamina = max_jetpack_stamina
		falling = false

func enforce_max_height():
	if position.y < -500:
		position.y = -500

#Jump gradual, mario-like
func jump():
	if Input.is_action_just_released("Jump"):
		falling = true
		jump_stamina = 0
		
	elif Input.is_action_pressed("Jump") and jump_stamina > 0:
		position.y -= 5
		motion.y -= 150
		jump_stamina -= 25 
		jumping = true
		$AnimatedSprite.play('jump')
	
	elif Input.is_action_pressed("Jump") and jetpack_stamina > 0 and falling:
		position.y -= 5
		motion.y -=  21
		jetpack_stamina -= 1
		jumping = true
		$AnimatedSprite.play('jump')

func hurt():
		hp -= 25
