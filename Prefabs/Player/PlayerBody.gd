extends KinematicBody2D

export var SPEED = 225
export var SPEED_DIF_MOD = 0
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
var jetpack_started = false
var falling =  false
var jumping = false
var jetpack_boost_speed = 0
var boosting = false

var jetpack_recharge_left = 50
var started_jetpack_recharge = false
var recharging_jetpack = false


func _ready():
	$AnimatedSprite.play('default')

	
func _physics_process(delta):
	motion.x = (SPEED + SPEED_DIF_MOD) + jetpack_boost_speed 
	check_jetpack_stamina_recharger()
	if recharging_jetpack:
		recharge_jetpack()
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
	if !boosting:
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
	if position.y < -800:
		position.y = -800

#Jump gradual, mario-like
func jump():
	if !boosting:
		if Input.is_action_just_released("Jump"):
			jump_fall()
			
		elif Input.is_action_pressed("Jump") and jump_stamina > 0:
			jump_normal()
			
		
		elif Input.is_action_pressed("Jump") and jetpack_stamina > 0 and falling:
			jump_jetpack()
				
		
		elif jump_stamina <= 0:
			$AudioJetpack.stop()
			jetpack_started = false
		
		

func update_jetpack_stamina(change):
	var newStamina = jetpack_stamina + change
	if newStamina <= 0:
		newStamina = 0
	elif newStamina >= max_jetpack_stamina:
		newStamina = max_jetpack_stamina
	jetpack_stamina = newStamina
	

func jump_normal():
#		NO BORRAR NO BORRAR NO BORRAR
		#SALTO SENSIBLE
		position.y -= 5 if is_on_floor() else 0
		motion.y -= 150
		jump_stamina -= 25
		#SALTO NO-SENSIBLE
#		motion.y -= 450 if is_on_floor() else 0 
#		position.y -= 5
#		jump_stamina -= 25 
		jumping = true
		$AnimatedSprite.play('jump')
		$AudioJump.play()
	
func jump_jetpack():
		$AudioJetpack.play()
		position.y -= 5
		if jetpack_started:
			motion.y -= 18
			update_jetpack_stamina(-1)
			if !$AudioJetpack.playing:
				$AudioJetpack.play()
		else:
			motion.y = -150
			jetpack_started = true
			update_jetpack_stamina(-10)
			$AudioBoost.play()
			
		jumping = true
		$AnimatedSprite.play('jump')
		$AnimatedSprite/Jetpack.play('on')

func jump_fall():
			falling = true
			jump_stamina = 0
			$AnimatedSprite/Jetpack.play('off')
			$AudioJetpack.stop()
			jetpack_started = false

func set_jetpack_boost():
	if Input.is_action_just_pressed("Right") and jetpack_stamina >= 25:
			update_jetpack_stamina(-50)
			boosting = true
			$AnimatedSprite/Jetpack/JetpackAnimation.play("jetpack_boost")
			motion.y = 0
			jetpack_boost_speed = 200
			$AudioBoost.play()
			
	elif Input.is_action_just_pressed("Left") and jetpack_stamina >= 25:
			update_jetpack_stamina(-50)
			boosting = true
			$AnimatedSprite/Jetpack/JetpackAnimation.play("jetpack_boost_left")
			motion.y = 0
			jetpack_boost_speed = -SPEED + -SPEED_DIF_MOD + -200
			$AudioBoost.play()

func end_jetpack_boost():
	$AnimatedSprite/Jetpack/JetpackAnimation.play("default")
	boosting = false
	jetpack_boost_speed = 0
	

func increase_difficulty():
	if SPEED_DIF_MOD < 500:
		SPEED_DIF_MOD += 20

func increase_world_level(worldLevel):
	SPEED_DIF_MOD = 0


func check_jetpack_stamina_recharger():
	if jetpack_stamina < 50 and !started_jetpack_recharge:
		$AnimatedSprite/Jetpack/Jetpack_recharge_timer.start()
		started_jetpack_recharge = true

func _on_Jetpack_recharge_timer_timeout():
		jetpack_recharge_left = 50
		recharging_jetpack = true
		
func recharge_jetpack():
	if jetpack_recharge_left > 0 and jetpack_stamina < 50:
		jetpack_stamina += 1
		jetpack_recharge_left -= 1
	else:
		recharging_jetpack = false
		started_jetpack_recharge = false


