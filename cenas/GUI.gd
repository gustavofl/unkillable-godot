extends CanvasLayer

onready var bar = $interface/Bars/Healthbar/TextureProgress
onready var player = $"../player"

func _ready():
	bar.max_value = Global.player_max_life
	bar.value = Global.player_max_life
