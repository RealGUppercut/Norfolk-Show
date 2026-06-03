extends Node2D

var RegularEnemy: PackedScene = load("res://components/regular_enemy.tscn")
@export var min_y: float = -100.0
@export var max_y: float = 100.0
@export var spawn_x: float = 0.0

func _process(delta: float) -> void:
	spawn_random_y()

func spawn_random_y():
	var y = randf_range(min_y, max_y)
	var instance = RegularEnemy.instantiate()
	instance.position = Vector2(spawn_x, y)
	add_child(instance)
