extends Node2D

func _ready():
	$music.volume_db = Global.get_volume_background()