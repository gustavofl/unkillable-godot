extends Node2D


func _ready():
	$music.volume_db = Global.get_volume_background()
	
	Global.next_scene = "res://cenas/segunda_cena.tscn"
	
	if Global.inicio_jogo:
		$GUI/dialogo_inicial.get_child(0).iniciar_dialogo()
		Global.inicio_jogo = false