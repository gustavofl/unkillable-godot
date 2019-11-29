extends StaticBody2D

const speed = 0.4
const max_life = 30
const INTERVALO_ESCRAVOS = 7 # em segundos

var posicao_inicial = Vector2()
var dano = 12
var flip = true
var posicao_final
var life = max_life

var tomando_dano = false
var morrendo = false
var criando_escravo = false
var timer_escravo = INTERVALO_ESCRAVOS

func _ready():
	$Sprite.play("idle");
	
	$healthBar/bar.max_value = max_life
	$healthBar/bar.value = life
	
	posicao_inicial = get_position()

func _process(delta):
	if criando_escravo:
		timer_escravo += delta
		if timer_escravo >= INTERVALO_ESCRAVOS:
			timer_escravo -= INTERVALO_ESCRAVOS
		
			var zumbi_resource = preload("zumbi-male.tscn")
			var zumbi = zumbi_resource.instance()
			var posicao = get_position()
			posicao.x -= 100
			posicao.y += 37
			zumbi.set_position(posicao)
			$"../..".add_child(zumbi)
			zumbi.flip = false

func dano(body, amount):
	tomando_dano = true
	
	life -= amount
	$healthBar/bar.value = life
	
	if life <= 0:
		die()
	else:
		get_node("anim").play("hurt")

func die():
	morrendo = true
	get_node("anim").play("die")

func destroy():
	$".".queue_free()
	
	var power_up_resource = preload("../colecionaveis/power_up.tscn")
	var power_up = power_up_resource.instance()
	power_up.set_position(get_position())
	$"../..".add_child(power_up)

func _on_anim_animation_finished(anim_name):
	if(anim_name == "hurt"):
		tomando_dano = false
		# $Sprite.play("walk")

func reviver():
	set_position(posicao_inicial)
	
	life = max_life
	$healthBar/bar.value = life

func criar_escravo(body):
	criando_escravo = true