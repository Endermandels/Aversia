extends CharacterBody2D
class_name Player

@export_group("External Nodes")
@export var projectile_spawn: Node

@export_group("Internal Nodes")
@export var input_cmp: InputComponent
@export var movement_cmp: MovementComponent
@export var animation_cmp: AnimationComponent

@export_group("Resources")
@export var spray: PackedScene

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	animation_cmp.handle_facing_direction(self)

func _physics_process(_delta: float) -> void:
	movement_cmp.handle_movement(self, Vector2.ZERO if Console.visible else input_cmp.input_vector)
	if not Console.visible:
		if input_cmp.spray:
			spawn_spray()

	move_and_slide()

func spawn_spray() -> void:
	var spawn: Spray = spray.instantiate()
	spawn.global_position = global_position
	spawn.rotation = input_cmp.spray_vector.angle()
	spawn.input_vector = input_cmp.spray_vector
	projectile_spawn.add_child(spawn)
	input_cmp.spray = false
