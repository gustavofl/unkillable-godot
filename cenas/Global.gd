extends Node

const DIFICULDADE_FACIL = 0
const DIFICULDADE_DIFICIL = 1
const VOLUME_MIN = -80
const VOLUME_MAXIMO = -5
const CENA_PRINCIPAL = "res://cenas/cena_principal.tscn"

var volume_porcentagem = 50
var dificuldade = DIFICULDADE_FACIL
var next_scene
var player_attack = 5
var player_max_life = 20
var player_current_life

# usado no dialogo inicial do jogo
var inicio_jogo = true

func get_volume_menu():
	return calcular_volume(volume_porcentagem)

func get_volume_background():
	return calcular_volume(volume_porcentagem) * 0.7

func calcular_volume(porcentagem):
	return -80 + (VOLUME_MAXIMO-VOLUME_MIN)/100.0 * porcentagem