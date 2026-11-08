extends CharacterBody2D
class_name Player

@export_group("Internal Nodes")
@export var input_cmp: InputComponent
@export var movement_cmp: MovementComponent
@export var animation_cmp: AnimationComponent

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	animation_cmp.handle_facing_direction(self)

func _physics_process(_delta: float) -> void:
	movement_cmp.handle_movement(self, Vector2.ZERO if Console.visible else input_cmp.input_vector)

	move_and_slide()
