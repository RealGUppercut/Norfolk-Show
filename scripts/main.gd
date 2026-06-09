extends Node2D

var score = 0
var lives = 5
var max_lives = 5

func _ready():
	$ScoreLabel.text = "0"
	GameEvent.score_added.connect(_on_score_added)
	GameEvent.heart_powerup.connect(_on_heart_powerup)
	print("=== MAIN READY ===")

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
	print("lose life called, lives remaining: " + str(lives))
	lives -= 1
	get_node("Heart" + str(lives + 1)).visible = false
	$BadFishSound.play()
	if lives <= 0:
		game_over()

func miss_fish():
	score = max(0, score - 2)
	$ScoreLabel.text = str(score)
	print("fish missed, score: " + str(score))

func game_over():
	GameData.final_score = score
	get_tree().change_scene_to_file("res://components/game_over.tscn")

func _on_area_2d_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	pass
