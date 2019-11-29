extends Label

var tempo_passado = 0

func _process(delta):
	if OS.get_ticks_msec() / 1000 != tempo_passado:
		tempo_passado = OS.get_ticks_msec() / 1000
		
		var hora = ""
		
		if tempo_passado/60 < 10:
			hora += "0"
		hora += String(tempo_passado/60)
		hora += ":"
		if tempo_passado%60 < 10:
			hora += "0"
		hora += String(tempo_passado%60)
		
		$".".set_text(hora)