extends Node
class_name CreatureAI

enum State {
    IDLE,
    WANDER,
    FLEE,
    PURSUE,
    INVESTIGATE
}

@export_group("Settings")
@export var idle_time_min: float = 2.0
@export var idle_time_max: float = 5.0
@export var wander_time_min: float = 1.0
@export var wander_time_max: float = 3.0

var transitioned: bool = false
var current_state: State = State.IDLE
var input_vector: Vector2 = Vector2.ZERO

func idle(_delta: float) -> void:
    if not transitioned:
        var timer = get_tree().create_timer(randf_range(idle_time_min, idle_time_max))
        timer.timeout.connect(transition.bind(State.WANDER))
        input_vector = Vector2.ZERO
        transitioned = true

func wander(_delta: float) -> void:
    if not transitioned:
        var timer = get_tree().create_timer(randf_range(wander_time_min, wander_time_max))
        timer.timeout.connect(transition.bind(State.IDLE))
        input_vector = Vector2(1 - randf() * 2, 1 - randf() * 2).normalized()
        transitioned = true

func transition(state: State) -> void:
    if state == current_state:
        return
    
    current_state = state
    transitioned = false

func _physics_process(delta: float) -> void:
    match current_state:
        State.IDLE:
            idle(delta)
        State.WANDER:
            wander(delta)