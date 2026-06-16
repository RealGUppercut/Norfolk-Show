extends RigidBody2D

enum FishType {
	REGULAR,
	SHIELD,
	HEART,
}

var fish_type = FishType.REGULAR

var type_colors = {
	FishType.REGULAR: Color(1, 1, 1),
	FishType.SHIELD: Color(2.0, 2.0, 0.0),
	FishType.HEART: Color(2.0, 0.4, 0.6),
}

var pulse_speed = 4.0
var pulse_amount = 0.15
var base_scale = Vector2(1, 1)

func _ready():
	if fish_type != 5:
		$Sprite2D.modulate = type_colors[fish_type]
	
func _process(delta: float) -> void:
	if fish_type != FishType.REGULAR:
		var pulse = 1.0 + sin(Time.get_ticks_msec() * 0.005 * pulse_speed) * pulse_amount
		$Sprite2D.scale = base_scale * pulse
		
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
			FishType.SHIELD:
				GameEvent.score_added.emit(1)
				GameEvent.shield_powerup.emit()
				print("SHIELD powerup collected!")
			FishType.HEART:
				GameEvent.score_added.emit(1)
				GameEvent.heart_powerup.emit()
				print("HEART powerup collected!")
		queue_free()
