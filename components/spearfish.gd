extends RigidBody2D

"res://sprites/entities/spearfish.png"

@export var base_speed = 175

func _ready():
	gravity_scale = 0
	# get player y position
	var player = get_tree().get_root().get_node("main/Player")
	if player:
		position.y = player.position.y
	linear_velocity = Vector2(base_speed * 1.75, 0)

func on_caught():
	GameEvent.life_lost.emit()
	queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		on_caught()
