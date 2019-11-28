extends StaticBody2D

func _on_colisao_body_entered(body):
	# body.increment_max_life()
	body.increment_attack()
	$".".queue_free()