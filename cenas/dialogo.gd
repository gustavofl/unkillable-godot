extends PopupMenu

func iniciar_dialogo():
	get_tree().paused = true
	show()
	
func _on_proximo_pressed():
	var quantidade_dialogos = $"..".get_child_count()
	var indice_dialogo = get_index()
	
	$".".hide()
	
	if indice_dialogo < quantidade_dialogos-1:
		var proximo_dialogo = $"..".get_child(indice_dialogo+1)
		proximo_dialogo.show()
	else:
		get_tree().paused = false

func _on_pular_pressed():
	$".".hide()
	get_tree().paused = false
