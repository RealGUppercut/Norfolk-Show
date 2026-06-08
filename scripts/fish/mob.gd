extends RigidBody2D

@export var speed = 100

enum FishType {
	REGULAR,
	BAD,
	NET,
	HEART,
	SPEED
}

var fish_type = FishType.REGULAR

# Colors for each type
var type_colors = {
		FishType.REGULAR: Color(1, 1, 1),
		FishType.BAD: Color(1, 0, 0),
		FishType.NET: Color(0.2, 1, 0.2),
		FishType.HEART: Color(1, 0.5, 0.8),
		FishType.SPEED: Color(0.3, 0.5, 1)
	
	
}

func _ready():
	if randf() < 0.3:
		$Sprite2D.modulate = type_colors[fish_type]
	linear_velocity = Vector2(speed, 0)

func _on_visible_on_screen_notifier_2d_screen_exited():
	# only lose life if regular fish escapes
	if fish_type == FishType.REGULAR:
		GameEvent.score_added.emit(-1)
	queue_free()
		
func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		match fish_type:
			FishType.REGULAR:
				GameEvent.score_added.emit(3)
			FishType.BAD:
				get_tree().get_root().get_node("main").lose_life()
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
				
