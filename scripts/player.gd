extends CharacterBody2D

@export var max_speed = 300
@export var default_speed = 150
@export var speed = 150
@export var time = 0

var net_scale = Vector2(1, 1)
var net_grow_amount = 0.3
var max_net_scale = Vector2(2.5, 2.5)

func _ready():
	GameEvent.net_powerup.connect(_on_net_powerup)
	print("=== PLAYER READY ===")

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed

func _physics_process(delta):
	get_input()

	if velocity == Vector2.ZERO:
		$MovementTime.stop()
		if $ResetMoveSpeed.is_stopped():
			$ResetMoveSpeed.start()
	else:
		$MovementTime.start()
		$ResetMoveSpeed.stop()

	move_and_slide()
	position.x = clamp(position.x, -225, 230)
	position.y = clamp(position.y, -130, 120)

func _on_net_powerup():
	print("=== NET SIGNAL RECEIVED ===")
	net_scale += Vector2(net_grow_amount, net_grow_amount)
	net_scale.x = min(net_scale.x, max_net_scale.x)
	net_scale.y = min(net_scale.y, max_net_scale.y)

	if has_node("CollisionShape2D"):
		$CollisionShape2D.scale = net_scale
	if has_node("Sprite2D"):
		$Sprite2D.scale = net_scale

	print("Net grew! New scale: ", net_scale)

	await get_tree().create_timer(10.0).timeout

	net_scale = Vector2(1, 1)

	if has_node("CollisionShape2D"):
		$CollisionShape2D.scale = net_scale
	if has_node("Sprite2D"):
		$Sprite2D.scale = net_scale

	print("Net returned to normal")

func _on_movement_time_timeout() -> void:
	if speed < max_speed:
		speed += 0.5

func _on_reset_move_speed_timeout() -> void:
	speed = default_speed
