extends CharacterBody2D
class_name Player

@export_group("External Nodes")
@export var projectile_spawn: Node

@export_group("Internal Nodes")
@export var input_cmp: InputComponent
@export var movement_cmp: MovementComponent
@export var animation_cmp: AnimationComponent
@export var gun_cmp: GunComponent

func _process(_delta: float) -> void:
	animation_cmp.handle_facing_direction(self)

func _physics_process(_delta: float) -> void:
	movement_cmp.handle_movement(self, Vector2.ZERO if Console.visible else input_cmp.input_vector)
	if not Console.visible:
		if input_cmp.spray:
			gun_cmp.shoot(input_cmp.spray_vector, projectile_spawn)
			input_cmp.spray = false

	move_and_slide()
