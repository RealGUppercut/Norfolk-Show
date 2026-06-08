extends Timer

var textures = ["res://sprites/entities/fish_1.png", ]

var RegularFish: PackedScene = load("res://components/regular_fish.tscn")
var RegularEnemy: PackedScene = load("res://components/regular_enemy.tscn")

#ADD NEW ENEMIES HERE IT WILL AUTOMATICALLY RANDOMIZE IT
var EnemyList = [
	RegularEnemy
]

var SpawnTimeDefault = 2
var DifficultyScale = 1
var FishSpeed = 10

func _on_timeout() -> void:
	spawn_random_y(0)
	if DifficultyScale > 2:
		spawn_random_y(2)
	if DifficultyScale > 3:
		spawn_random_y(-2)
	
func spawn_random_y(y_add):
	var instance = null
	var IsEnemy = randi_range(0, 2)
	if IsEnemy == 2:
		var randNumber = randi_range(1, 4)
		
		var StrongEnemy = randi_range(0,3)
		if StrongEnemy == 3:
			var Enemy = EnemyList.pick_random()
			instance = Enemy.instantiate()
		else:
			instance = RegularEnemy.instantiate()
		
		
		var sprite = instance.get_node("Mob/Sprite2D")
		sprite.texture = load("res://sprites/entities/fish_%d.png" % randNumber)
	else:
		var randNumber = randi_range(1, 4)
		
		instance = RegularFish.instantiate()
		
		var sprite = instance.get_node("Mob/Sprite2D")
		sprite.texture = load("res://sprites/entities/fish_%d.png" % randNumber)
	
	var y = randf_range(-100.0, 100.0)
	instance.position = Vector2(-250, y + y_add)
	instance.get_node("Mob").constant_force[0] = (FishSpeed * DifficultyScale)
	
	get_parent().add_child(instance)


func _on_difficulty_scaler_timeout() -> void:
	DifficultyScale += 0.05
	print($".")
	if SpawnTimeDefault/DifficultyScale > 0.5:
		$".".wait_time = SpawnTimeDefault/DifficultyScale
