extends StaticBody2D

func _on_colisao_body_entered(body):
	var popup = $"../GUI/power_up_popup"
	popup.show()
	get_tree().paused = true
	$".".queue_free()