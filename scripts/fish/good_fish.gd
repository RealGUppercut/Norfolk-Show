extends RigidBody2D

enum FishType {
	REGULAR,
	NET,
	HEART,
}

var fish_type = FishType.REGULAR

var type_colors = {
	FishType.REGULAR: Color(1, 1, 1),
	FishType.NET: Color(0.82, 0.075, 1.0, 1.0),
	FishType.HEART: Color(0.341, 0.157, 1.0, 1.0),
}

func _ready():
	$Sprite2D.modulate = type_colors[fish_type]

func _on_visible_on_screen_notifier_2d_screen_exited():
	if fish_type == FishType.REGULAR:
		get_tree().get_root().get_node("main").miss_fish()
	queue_free()

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		match fish_type:
			FishType.REGULAR:
				GameEvent.score_added.emit(3)
				print("Regular fish caught! +3 score")
			FishType.NET:
				GameEvent.score_added.emit(1)
				GameEvent.net_powerup.emit()
				print("NET powerup collected!")
			FishType.HEART:
				GameEvent.score_added.emit(1)
				GameEvent.heart_powerup.emit()
				print("HEART powerup collected!")
		queue_free()
