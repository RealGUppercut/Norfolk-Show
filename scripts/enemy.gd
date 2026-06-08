extends Node

enum FishType {
	REGULAR,
	NET,
	HEART,
	SPEED
}

var fish_type = FishType.REGULAR

var type_colors = {
	FishType.REGULAR: Color(1, 1, 1),
	FishType.NET: Color(0.2, 1, 0.2),
	FishType.HEART: Color(1, 0.5, 0.8),
	FishType.SPEED: Color(0.3, 0.5, 1),
}

func _ready() -> void:
	$Sprite2D.modulate = type_colors[fish_type]

func on_caught():
	match fish_type:
		FishType.REGULAR:
			GameEvent.score_added.emit(3)
		FishType.NET:
			GameEvent.score_added.emit(1)
			GameEvent.net_powerup.emit()
		FishType.HEART:
			GameEvent.score_added.emit(1)
			GameEvent.heart_powerup.emit()
		FishType.SPEED:
			GameEvent.score_added.emit(1)
			GameEvent.speed_powerup.emit()
	queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
