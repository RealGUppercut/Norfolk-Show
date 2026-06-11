extends RigidBody2D

@export var speed = 60

func _ready():
	gravity_scale = 0
	linear_velocity = Vector2(speed, 0)

func on_caught():
	var main = get_tree().get_root().get_node("main")
	if main:
		main.get_node("SpecialFishSound").play()
	GameEvent.life_lost.emit()
	GameEvent.life_lost.emit()
	GameEvent.life_lost.emit()
	queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		on_caught()
