extends KinematicBody2D

const UP = Vector2(0, -1)
const SPEED = 200
const GRAVITY = 43000
const JUMP_HEIGHT = 25000
const DASH = 150

var speed_y = 0
var motion = Vector2()
var max_life = 20
var life
var forca_ataque = 5

var sprite_travado = false
var atacando = false
var tomando_dano = false

func _ready():
	life = max_life
	$ataque_direita/shape.disabled = true
	$ataque_esquerda/shape.disabled = true

func _physics_process(delta):
	
	if Input.is_action_pressed("ui_right"):
		motion.x = SPEED
	elif Input.is_action_pressed("ui_left"):
		motion.x = -SPEED
	else:
		motion.x = 0
	
	if sprite_travado:
		if atacando:
			if($Sprite.flip_h):
				motion.x = -DASH
			else:
				motion.x = DASH
		elif tomando_dano:
			if($Sprite.flip_h):
				motion.x = DASH
			else:
				motion.x = -DASH
	else:
		if Input.is_action_pressed("ui_right"):
			motion.x = SPEED
		elif Input.is_action_pressed("ui_left"):
			motion.x = -SPEED
		else:
			motion.x = 0
		
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
		if $Sprite.flip_h:
			$ataque_esquerda/shape.disabled = false
		else:
			$ataque_direita/shape.disabled = false
		sprite_travado = true
		atacando = true
		
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			speed_y = -JUMP_HEIGHT
		else:
			speed_y = 0
	else:
		$Sprite.play("jump")
	
	if is_on_ceiling():
		speed_y = 0
	
	speed_y += GRAVITY * delta
	
	motion.y = speed_y * delta
	
	motion = move_and_slide(motion, UP)

func _on_dano_body_entered(body):
	if(body.morrendo):
		return
	
	increment_life(-body.dano)
	
	if life <= 0:
		get_tree().change_scene("res://cenas/menu.tscn")
	else:
		$Sprite.play("hurt")
		sprite_travado = true
		tomando_dano = true

func increment_life(amount):
	var healthBar = $"../GUI/interface/VBoxContainer/Healthbar/TextureProgress"
	life += amount
	healthBar.value = life

func _on_Sprite_animation_finished():
	if atacando:
		$Sprite.play("idle")
		if $Sprite.flip_h:
			$ataque_esquerda/shape.disabled = true
		else:
			$ataque_direita/shape.disabled = true
		sprite_travado = false
		atacando = false
	elif tomando_dano:
		$Sprite.play("idle")
		sprite_travado = false
		tomando_dano = false

func _on_ataque_direita_body_entered(body):
	$".".add_collision_exception_with(body)
	body.dano(self, forca_ataque)

func _on_ataque_esquerda_body_entered(body):
	$".".add_collision_exception_with(body)
	body.dano(self, forca_ataque)
