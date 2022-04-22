extends KinematicBody2D

export var SPEED = 200
export var GRAVITY = 20
const WORLD_LIMIT = 10000 #BAJAR
const UP = Vector2(0,-1)
var motion = Vector2(SPEED,0)
var hurting = false


export var hp = 100
export var jump_speed = 50
export var jump_stamina = 75
export var max_jump_stamina = 75

export var jetpack_stamina = 500
export var max_jetpack_stamina = 500
var falling =  false
var jumping = false
var jetpack_boost_speed = 0
var boosting = false

func _ready():
	$AnimatedSprite.play('default')

	
func _physics_process(delta):
	motion.x = SPEED + jetpack_boost_speed 
	apply_gravity()
	handle_movement()
	jump()
	animate()
	set_jetpack_boost()
	move_and_slide(motion, UP)
	on_floor_collision()
	get_tree().call_group("Game_UI", "update_ui", hp, jetpack_stamina)
	enforce_max_height()



func apply_gravity():
		if !is_on_floor():
			motion.y += GRAVITY
		else:
			motion.y = GRAVITY
			

func animate():
	if hurting:
		$AnimatedSprite.play('hurt')
	elif is_on_floor():
		$AnimatedSprite.play('run')

func handle_movement():
	move_and_slide(motion, UP)
	
func on_floor_collision():
	if is_on_floor():
		jump_stamina = max_jump_stamina
		falling = false
		$AnimatedSprite/Jetpack.play('off')

func enforce_max_height():
	if position.y < -500:
		position.y = -500

#Jump gradual, mario-like
func jump():
	if !boosting:
		if Input.is_action_just_released("Jump"):
			falling = true
			jump_stamina = 0
			$AnimatedSprite/Jetpack.play('off')
			
		elif Input.is_action_pressed("Jump") and jump_stamina > 0:
			position.y -= 5
			motion.y -= 150
			jump_stamina -= 25 
			jumping = true
			$AnimatedSprite.play('jump')
			
		
		elif Input.is_action_pressed("Jump") and jetpack_stamina > 0 and falling:
			position.y -= 5
			motion.y -=  21
			update_jetpack_stamina(-1)
			jumping = true
			$AnimatedSprite.play('jump')
			$AnimatedSprite/Jetpack.play('on')
		
		

func update_jetpack_stamina(change):
	var newStamina = jetpack_stamina + change
	if newStamina <= 0:
		newStamina = 0
	elif newStamina >= max_jetpack_stamina:
		newStamina = max_jetpack_stamina
	jetpack_stamina = newStamina
	

func set_jetpack_boost():
	if Input.is_action_just_pressed("Right") and jetpack_stamina >= 25:
			update_jetpack_stamina(-50)
			boosting = true
			$AnimatedSprite/Jetpack/JetpackAnimation.play("jetpack_boost")
			motion.y = -300
			jetpack_boost_speed = 150
		
		
func end_jetpack_boost():
	$AnimatedSprite/Jetpack/JetpackAnimation.play("default")
	boosting = false
	jetpack_boost_speed = 0
	
