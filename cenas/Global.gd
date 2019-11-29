extends Node

const DIFICULDADE_FACIL = 0
const DIFICULDADE_DIFICIL = 1
const VOLUME_MIN = -80
const VOLUME_MAXIMO = -5

var volume_porcentagem = 50
var dificuldade = DIFICULDADE_FACIL

func get_volume_menu():
	return calcular_volume(volume_porcentagem)

func get_volume_background():
	return calcular_volume(volume_porcentagem) * 0.7

func calcular_volume(porcentagem):
	return -80 + (VOLUME_MAXIMO-VOLUME_MIN)/100.0 * porcentagem