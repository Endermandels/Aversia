extends Node2D
class_name GunComponent

"""
Use this component to shoot projectiles
"""

@export_group("Settings")
@export var cooldown_time: float = 0.1

@export_group("Resources")
@export var projectile: PackedScene

var is_cooling_down: bool = false

func shoot(projectile_vector: Vector2, projectile_spawn_node: Node) -> void:
    if not is_cooling_down:
        var timer := get_tree().create_timer(cooldown_time)
        var spawn: ProjectileComponent = projectile.instantiate()
        spawn.global_position = global_position
        spawn.rotation = projectile_vector.angle()
        spawn.input_vector = projectile_vector
        projectile_spawn_node.add_child(spawn)
        is_cooling_down = true
        timer.timeout.connect(func(): is_cooling_down = false)
