extends Node2D

var score = 0
var lives = 5
var max_lives = 5
var is_shielded = false
var shield_id = 0
var shield_time_remaining = 0.0

@onready var shield_timer_label = get_node_or_null("CanvasLayer/UI/ShieldTimer")

func _ready():
	$ScoreLabel.text = "0"

	if shield_timer_label:
		shield_timer_label.text = ""
		shield_timer_label.visible = false
		print("Shield timer found")
	else:
		print("Shield timer NOT found")

	GameEvent.score_added.connect(_on_score_added)
	GameEvent.heart_powerup.connect(_on_heart_powerup)
	GameEvent.shield_powerup.connect(_on_shield_powerup)
	GameEvent.life_lost.connect(_on_life_lost)
	print("=== MAIN READY ===")

func _process(delta):
	if shield_timer_label == null:
		return

	if is_shielded:
		shield_time_remaining -= delta
		if shield_time_remaining > 0:
			shield_timer_label.visible = true
			shield_timer_label.text = "SHIELD " + str(int(ceil(shield_time_remaining))) + "s"
		else:
			shield_timer_label.visible = false
			shield_timer_label.text = ""
	else:
		shield_timer_label.visible = false
		shield_timer_label.text = ""

func _on_life_lost():
	lose_life()

func _on_score_added(amount):
	score += amount
	$ScoreLabel.text = str(score)
	$GoodFishSound.play()

func _on_heart_powerup():
	if lives < max_lives:
		lives += 1
		get_node("Heart" + str(lives)).visible = true
		print("Heart restored! Lives: ", lives)
	else:
		score += 5
		$ScoreLabel.text = str(score)
		print("Full health! Bonus points instead!")

func add_score():
	score += 3
	$ScoreLabel.text = str(score)

func lose_life():
	if is_shielded:
		print("SHIELDED! No life lost!")
		return

	print("lose life called, lives remaining: " + str(lives))
	lives -= 1
	var heart = get_node_or_null("Heart" + str(lives + 1))
	if heart:
		heart.visible = false

	var bad_sound = get_node_or_null("BadFishSound")
	if bad_sound:
		bad_sound.play()

	if lives <= 0:
		game_over()

func miss_fish():
	score = max(0, score - 1)
	$ScoreLabel.text = str(score)
	print("fish missed, score: " + str(score))

func game_over():
	GameData.final_score = score
	get_tree().change_scene_to_file.call_deferred("res://components/game_over.tscn")

func _on_shield_powerup():
	print("SHIELD ACTIVATED")
	is_shielded = true
	shield_time_remaining = 10.0

	if shield_timer_label:
		shield_timer_label.visible = true
		shield_timer_label.text = "SHIELD 10s"

	shield_id += 1
	var current_shield_id = shield_id

	await get_tree().create_timer(10.0).timeout

	if current_shield_id != shield_id:
		return

	is_shielded = false
	shield_time_remaining = 0.0

	if shield_timer_label:
		shield_timer_label.visible = false
		shield_timer_label.text = ""

	print("Shield expired")

func _on_area_2d_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	pass
