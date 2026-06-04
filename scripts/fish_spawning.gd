extends Timer

var textures = ["res://sprites/entities/fish_1.png", ]

var RegularFish: PackedScene = load("res://components/regular_fish.tscn")

func _on_timeout() -> void:
	spawn_random_y()
	
func spawn_random_y():
	var y = randf_range(-100.0, 100.0)
	var randNumber = randi_range(1, 4)
	var instance = RegularFish.instantiate()
	instance.position = Vector2(-250, y)
	var sprite = instance.get_node("Mob/Sprite2D")
	sprite.texture = load("res://sprites/entities/fish_%d.png" % randNumber)
	get_parent().add_child(instance)
