extends CharacterBody2D
class_name ProjectileComponent

@export_group("Settings")
@export var time_to_deceleration: float = 0.5
@export var deceleration: float = 0.05

@export_group("Internal Nodes")
@export var movement_cmp: MovementComponent

var input_vector: Vector2 = Vector2.RIGHT

func _ready() -> void:
    var timer = get_tree().create_timer(time_to_deceleration)
    timer.timeout.connect(start_decelerating)

func _physics_process(_delta: float) -> void:
    movement_cmp.handle_movement(self, input_vector)

    move_and_slide()

func start_decelerating() -> void:
    movement_cmp.acceleration = deceleration
    input_vector = Vector2.ZERO