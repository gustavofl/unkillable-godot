extends KinematicBody2D

const UP = Vector2(0, -1)
const SPEED = 200
const GRAVITY = 17000
const JUMP_HEIGHT = 14000

var speed_y = 0
var motion = Vector2()
var max_life = 20
var life
var ataque = false

func _ready():
	life = max_life
	$ataque/shape.disabled = true

func _physics_process(delta):
	
	if Input.is_action_pressed("ui_right"):
		motion.x = SPEED
	elif Input.is_action_pressed("ui_left"):
		motion.x = -SPEED
	else:
		motion.x = 0
	
	if $Sprite.animation != "attack":
		if Input.is_action_pressed("ui_right"):
			$Sprite.play("run")
			$Sprite.flip_h = false
		elif Input.is_action_pressed("ui_left"):
			$Sprite.play("run")
			$Sprite.flip_h = true
		else:
			$Sprite.play("idle")
		
	if Input.is_action_just_pressed("ui_atack"):
		$Sprite.play("attack")
		$ataque/shape.disabled = false
		
	if is_on_floor():
		if Input.is_action_pressed("ui_up"):
			speed_y = -JUMP_HEIGHT
		else:
			speed_y = 0
	else:
		$Sprite.play("jump")
	
	if is_on_ceiling():
		speed_y = -speed_y
	
	speed_y += GRAVITY * delta
	
	motion.y = speed_y * delta
	
	motion = move_and_slide(motion, UP)

func _on_pes_body_entered(body):
	body.dano()
	speed_y = -JUMP_HEIGHT

func _on_dano_body_entered(body):
	if(body.morrendo):
		return
	
	increment_life(-body.dano)
	
	if life <= 0:
		get_tree().change_scene("res://cenas/menu.tscn")

func increment_life(amount):
	var healthBar = $"../GUI/interface/VBoxContainer/Healthbar/TextureProgress"
	life += amount
	healthBar.value = life

func _on_Sprite_animation_finished():
	if $Sprite.animation == "attack":
		$Sprite.play("idle")
		$ataque/shape.disabled = true

func _on_ataque_body_entered(body):
	$".".add_collision_exception_with(body)
	body.dano()