extends CharacterBody2D
class_name Creature

@export_group("Internal Nodes")
@export var movement_cmp: MovementComponent
@export var animation_cmp: AnimationComponent
@export var creature_ai: CreatureAI

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	animation_cmp.handle_facing_direction(self)

func _physics_process(_delta: float) -> void:
	movement_cmp.handle_movement(self, creature_ai.input_vector)

	move_and_slide()
