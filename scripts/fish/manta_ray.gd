extends CanvasLayer

@onready var img = $TextureRect
@onready var timer = $MantaAttack

func show_image_for(seconds: float):
	img.visible = true
	timer.wait_time = seconds
	timer.start()

func _on_manta_attack_timeout() -> void:
	img.visible = false
