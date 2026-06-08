extends Node2D
var score = 0
var lives = 5

func _ready():
	$ScoreLabel.text = "0"

func add_score():
	score += 3
	$ScoreLabel.text = str(score)

func lose_life():
	print("lose life called, lives remaining: " + str(lives))
	lives -= 1
	get_node("Heart" + str(lives + 1)).visible = false
	if lives <= 0:
		game_over()

func game_over():
	get_tree().change_scene_to_file("res://components/main_menu.tscn")

func _on_area_2d_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	pass # Replace with function body.
