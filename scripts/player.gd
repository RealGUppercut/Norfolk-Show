extends CharacterBody2D

@export var max_speed = 300
@export var default_speed = 100

@export var speed = 100
@export var time = 0


func _ready():
	print("Player Ready")

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


func _on_movement_time_timeout() -> void:
	if speed < max_speed:
		speed += 0.5

func _on_reset_move_speed_timeout() -> void:
	speed = default_speed
