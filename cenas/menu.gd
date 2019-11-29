extends Control

const PORCENTAGEM_VOLUME_INICIAL = 50

func _ready():
	$DificuldadeOption.add_item("Normal", 0)
	$DificuldadeOption.add_item("Difícil", 1)
	$VolumeSlider.value = PORCENTAGEM_VOLUME_INICIAL
	$music.volume_db = Global.calcular_volume(PORCENTAGEM_VOLUME_INICIAL)

func _on_Iniciar_pressed():
	Global.volume_porcentagem = $VolumeSlider.value
	Global.dificuldade = $DificuldadeOption.get_selected_id()
	get_tree().change_scene("res://cenas/cena_principal.tscn")

func _on_Sair_pressed():
	get_tree().quit()

func _on_VolumeSlider_value_changed(value):
	$music.volume_db = Global.calcular_volume(value)
