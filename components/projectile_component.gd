extends CharacterBody2D
class_name ProjectileComponent

@export_group("Internal Nodes")
@export var movement_cmp: MovementComponent

var input_vector: Vector2 = Vector2.RIGHT

func _physics_process(_delta: float) -> void:
    movement_cmp.handle_movement(self, input_vector)

    move_and_slide()