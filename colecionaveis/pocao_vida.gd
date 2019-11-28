extends StaticBody2D

func _on_colisao_body_entered(body):
	if body.life < body.max_life:
		body.recuperar_vida()
		$".".queue_free()
