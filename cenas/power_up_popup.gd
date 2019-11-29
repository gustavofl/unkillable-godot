extends PopupMenu

func _on_aumentar_ataque_pressed():
	var player = $"../../player"
	player.increment_attack()
	fechar()

func _on_aumentar_vida_pressed():
	var player = $"../../player"
	player.increment_max_life()
	fechar()

func fechar():
	$".".hide()
	get_tree().paused = false
