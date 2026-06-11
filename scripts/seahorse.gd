extends RigidBody2D
@export var speed = 80
var is_mini = false

func _ready():
	gravity_scale = 0
	linear_velocity = Vector2(speed, 0)
	if is_mini:
		scale = Vector2(0.5, 0.5)

func on_caught():
	if not is_mini:
		spawn_mini_seahorses()
	else:
		GameEvent.life_lost.emit()
		queue_free()

func spawn_mini_seahorses():
	for i in range(5):
		var mini = load("res://components/seahorse.tscn").instantiate()
		mini.is_mini = true
		mini.position = Vector2(-250, randf_range(-100, 100))
		mini.linear_velocity = Vector2(randf_range(60, 120), randf_range(-30, 30))
		get_parent().add_child(mini)
	queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		on_caught()
