extends StaticBody2D

const speed = 0.4
const max_life = 10

var posicao_inicial = Vector2()
var dano = 5
var flip = true
var posicao_final
var life = max_life

var tomando_dano = false
var morrendo = false
var bateu_parede = false

func _ready():
	$Sprite.play("walk");
	
	$healthBar/bar.max_value = max_life
	$healthBar/bar.value = life
	
	posicao_inicial = get_position()
	
	flip = randi()%3 == 1

func _process(delta):
	if tomando_dano and not bateu_parede:
		if flip:
			$".".position.x -= speed
		else:
			$".".position.x += speed
	else:
		if flip:
			$".".position.x += speed
		else:
			$".".position.x -= speed
	
	if flip:
		$Sprite.flip_h = false
	else:
		$Sprite.flip_h = true

func dano(body, amount):
	tomando_dano = true
	
	if body.get_position().x < get_position().x:
		flip = false
	else:
		flip = true
	
	life -= amount
	$healthBar/bar.value = life
	
	if life <= 0:
		die()
	else:
		$Sprite.play("hurt")
		get_node("anim").play("hurt")

func die():
	morrendo = true
	get_node("anim").play("die")

func destroy():
	$".".queue_free()

func _on_chao_direita_body_exited(body):
	flip = true

func _on_chao_esquerda_body_exited(body):
	flip = false


func _on_anim_animation_finished(anim_name):
	if(anim_name == "hurt"):
		tomando_dano = false
		$Sprite.play("walk")

func reviver():
	set_position(posicao_inicial)
	
	life = max_life
	$healthBar/bar.value = life

func _on_parede_body_entered(body):
	flip = !flip
	bateu_parede = true

func _on_parede_body_exited(body):
	bateu_parede = false
