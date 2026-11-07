extends CharacterBody2D
class_name Player

@export_group("Internal Nodes")
@export var input_cmp: InputComponent
@export var movement_cmp: MovementComponent
@export var animation_cmp: AnimationComponent

func _ready() -> void:
	# Each client should have its own camera
	# var camera = Camera2D.new()
	# add_child(camera)
	pass

func _process(_delta: float) -> void:
	animation_cmp.handle_facing_direction(self)

func _physics_process(_delta: float) -> void:
	movement_cmp.handle_movement(self, input_cmp.input_vector)

	move_and_slide()
