extends AnimationPlayer
class_name AnimationComponent

@export_group("External Nodes")
@export var sprite: Sprite2D

var anim_lock: bool = false

func handle_facing_direction(body: CharacterBody2D) -> void:
	if not anim_lock:
		var ang: float = rad_to_deg(body.velocity.angle())
		
		if body.velocity.length() > 10 and current_animation != "run":
			# start moving
			play("run")
		elif body.velocity.length() < 10 and current_animation != "idle":
			# stop moving
			play("idle")

		if abs(ang) <= 85:
			# right
			sprite.flip_h = false
		elif abs(ang) >= 95:
			# left
			sprite.flip_h = true

func spray() -> void:
	if current_animation != "spray":
		play("spray")
		anim_lock = true
		await animation_finished
		anim_lock = false