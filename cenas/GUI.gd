extends CanvasLayer

onready var bar = $interface/Bars/Healthbar/TextureProgress
onready var player = $"../player"

func _ready():
	bar.max_value = player.max_life
	bar.value = player.max_life
