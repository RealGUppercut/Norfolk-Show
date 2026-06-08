extends RigidBody2D

func _ready():
	$Sprite2D.modulate = Color(1, 0, 0)

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		get_tree().get_root().get_node("main").lose_life()
		queue_free()
