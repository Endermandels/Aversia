extends Node
class_name InputComponent

''' Specifically, take input from the keyboard, mouse, etc. '''

@export_group("External Nodes")
@export var body: CharacterBody2D ## Body using inputs

var input_vector: Vector2 = Vector2.ZERO ## Normalized input vector for moving
var spray_vector: Vector2 = Vector2.ZERO ## Normalized input vector for spraying
var spray: bool = false ## Input for spraying

func _process(_delta: float) -> void:
	var h_dir: float = Input.get_axis("move_left", "move_right")
	var v_dir: float = Input.get_axis("move_up", "move_down")

	# Sticky input
	if not spray:
		spray = Input.is_action_pressed("spray")

	if not spray and not Console.visible:
		input_vector = Vector2(h_dir, v_dir).normalized()
	else:
		input_vector = Vector2.ZERO

func get_spray_vector() -> void:
	spray_vector = body.global_position.direction_to(body.get_global_mouse_position())
