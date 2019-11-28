extends StaticBody2D

const speed = 0.2
var dano = 5
var flip = true
var posicao_inicial
var posicao_final

var morrendo = false

func _ready():
	$Sprite.play("walk");
	posicao_inicial = $".".position.x
	posicao_final = posicao_inicial + 100

func _process(delta):
	if($".".position.x <= posicao_final and flip):
		$".".position.x += speed
		$Sprite.flip_h = false
		if($".".position.x >= posicao_final):
			flip = false
	
	if($".".position.x >= posicao_inicial and !flip):
		$".".position.x -= speed
		$Sprite.flip_h = true
		if($".".position.x <= posicao_inicial):
			flip = true

func dano():
	morrendo = true
	get_node("anim").play("die")

func die():
	$".".queue_free()