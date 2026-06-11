extends Timer

var textures = ["res://sprites/entities/fish_1.png"]
var RegularFish: PackedScene = load("res://components/regular_fish.tscn")
var RegularEnemy: PackedScene = load("res://components/regular_enemy.tscn")
var Seahorse: PackedScene = load("res://components/seahorse.tscn")
var Whale: PackedScene = load("res://components/whale.tscn")

var EnemyList = [
	load("res://components/regular_enemy.tscn"),  
]

var SpawnTimeDefault = 2
var DifficultyScale = 1
var FishSpeed = 10

# Spawn rates out of 100
var heart_chance = 5
var net_chance = 8
var seahorse_chance = 7
var whale_chance = 7

func _on_timeout() -> void:
	if DifficultyScale >= 1 and DifficultyScale < 2:
		spawn_random_y(1)
	elif DifficultyScale >= 2 and DifficultyScale < 3:
		spawn_random_y(2)
	elif DifficultyScale >= 3:
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
				var sprite = instance.get_node("Mob/Sprite2D")
				sprite.texture = load("res://sprites/entities/fish_%d.png" % randNumber)
		else:
			var fish_type = roll_fish_type()
			if fish_type == 3:
				var seahorse = Seahorse.instantiate()
				var y_pos = y + y_offset
				y_pos = wrapf(y_pos, -100, 100)
				seahorse.position = Vector2(-250, y_pos)
				get_parent().add_child(seahorse)
				y_offset += randi_range(30, 100)
				continue
			elif fish_type == 4:
				print("spawning whale!")
				var whale = Whale.instantiate()
				var y_pos = y + y_offset
				y_pos = wrapf(y_pos, -100, 100)
				whale.position = Vector2(-250, y_pos)
				get_parent().add_child(whale)
				y_offset += randi_range(30, 100)
				continue
			instance = RegularFish.instantiate()
			var randNumber = randi_range(1, 4)
			var sprite = instance.get_node("Mob/Sprite2D")
			sprite.texture = load("res://sprites/entities/fish_%d.png" % randNumber)
			var fish_node = instance.get_node("Mob")
			fish_node.fish_type = fish_type
		var y_pos = y + y_offset
		y_offset += randi_range(30, 100)
		y_pos = wrapf(y_pos, -100, 100)
		instance.position = Vector2(-250, y_pos)
		instance.get_node("Mob").constant_force.x = FishSpeed * DifficultyScale
		get_parent().add_child(instance)

func roll_fish_type():
	var roll = randi_range(1, 100)
	if roll <= heart_chance:
		return 2  # HEART
	elif roll <= heart_chance + net_chance:
		return 1  # NET
	elif roll <= heart_chance + net_chance + seahorse_chance:
		return 3  # SEAHORSE
	elif roll <= heart_chance + net_chance + seahorse_chance + whale_chance:
		return 4  # WHALE
	else:
		return 0  # REGULAR

func _on_difficulty_scaler_timeout() -> void:
	DifficultyScale += 0.01
	if SpawnTimeDefault / DifficultyScale > 0.5:
		$".".wait_time = SpawnTimeDefault / DifficultyScale
