extends CharacterBody2D

@export var max_speed = 350
@export var default_speed = 150
@export var speed = 150
@export var time = 0

var net_scale = Vector2(1, 1)
var net_boosted_scale = Vector2(1.8, 1.8)
var net_powerup_id = 0
var net_is_big = false

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

	if not net_is_big:
		net_scale = net_boosted_scale
		net_is_big = true
		print("Net grew! scale: ", net_scale)
	else:
		print("Net already big - timer reset")

	if has_node("CollisionShape2D"):
		$CollisionShape2D.scale = net_scale
	if has_node("Sprite2D"):
		$Sprite2D.scale = net_scale

	net_powerup_id += 1
	var current_power_up_id = net_powerup_id

	await get_tree().create_timer(10.0).timeout

	if current_power_up_id != net_powerup_id:
		return

	net_scale = Vector2(1, 1)
	net_is_big = false

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
