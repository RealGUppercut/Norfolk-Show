extends RigidBody2D
@export var speed = 80

func _ready():
	linear_velocity = Vector2(speed, 0)

func on_caught():
	var ui = get_parent().get_node("CanvasLayer")
	ui.show_image_for(2.0)
	GameEvent.life_lost.emit()
	queue_free()
	

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		on_caught()
