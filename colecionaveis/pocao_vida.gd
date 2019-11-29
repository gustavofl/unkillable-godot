extends StaticBody2D

func _on_colisao_body_entered(body):
	if body.life < Global.player_max_life:
		body.recuperar_vida()
		$".".queue_free()
