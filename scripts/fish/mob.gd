extends RigidBody2D

@export var speed = 100
var is_bad_fish = false

func _ready():
	if randf() < 0.3:
		is_bad_fish = true
		$Sprite2D.modulate = Color(1, 0, 0)
	linear_velocity = Vector2(speed, 0)

func _on_visible_on_screen_notifier_2d_screen_exited():
	if not is_bad_fish:
		get_tree().get_root().get_node("main").lose_life()
	queue_free()

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		if is_bad_fish:
			get_tree().get_root().get_node("main").lose_life()
		else:
			get_tree().get_root().get_node("main").add_score()
		queue_free()
