extends Node
class_name MovementComponent

@export_group("Settings")
@export var acceleration: float = 0.2
@export var max_speed: float = 200.0

func handle_movement(body: CharacterBody2D, dir: Vector2) -> void:
	body.velocity = body.velocity.lerp(dir * max_speed, acceleration)
