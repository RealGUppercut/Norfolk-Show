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
	if DifficultyScale < 2 and DifficultyScale >= 1: 
		spawn_random_y(1)
	if DifficultyScale < 3 and DifficultyScale >= 2: 
		spawn_random_y(2)
	if DifficultyScale >= 3: 
		spawn_random_y(3)
	
func spawn_random_y(AmountToSpawn):
	var y_offset := 0
	var y := randf_range(-100.0, 100.0)

	for i in range(AmountToSpawn):
		var instance = null
		var IsEnemy = randi_range(0, 2)

		if IsEnemy == 2:
			var randNumber = randi_range(1, 4)
			var StrongEnemy = randi_range(0, 3)
			if StrongEnemy == 3:
				instance = EnemyList.pick_random().instantiate()
			else:
				instance = RegularEnemy.instantiate()

				instance.get_node("Mob/Sprite2D").texture = load("res://sprites/entities/fish_%d.png" % randNumber)
		else:
			var randNumber = randi_range(1, 4)
			instance = RegularFish.instantiate()
			instance.get_node("Mob/Sprite2D").texture = load("res://sprites/entities/fish_%d.png" % randNumber)

		instance.get_node("Mob").constant_force.x = FishSpeed * DifficultyScale

		y_offset += randi_range(30, 100)
		
		var new_y = wrapf(y + y_offset, -100, 100)
		
		instance.position = Vector2(-250, new_y)
		get_parent().add_child(instance)



func _on_difficulty_scaler_timeout() -> void:
	DifficultyScale += 0.05
	print($".")
	if SpawnTimeDefault/DifficultyScale > 0.5:
		$".".wait_time = SpawnTimeDefault/DifficultyScale
