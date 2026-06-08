extends Node2D

func _ready():
	$ScoreLabel.text = "Score: " + str(GameData.final_score)

func _on_retry_pressed():
	get_tree().change_scene_to_file("res://components/main.tscn")

func _on_return_to_menu_pressed():
	get_tree().change_scene_to_file("res://components/main_menu.tscn")
