extends Node3D
class_name BaseBullet

@export var bullet_speed : float
@export var friendly_damage : float = 0.3

var bullet_dir : Vector3


func _ready() -> void:
	%Timer.start()

func _process(delta: float) -> void:
	position += bullet_dir * bullet_speed * delta

func _on_visible_on_screen_notifier_3d_screen_exited() -> void:
	queue_free()

func _on_area_3d_body_entered(body):
	if body.is_in_group("EnemyGroup"):
		body.queue_free()
		queue_free()
	elif body.get_parent().is_in_group("BubbleBaseGroup"):
		pass
		body.get_parent()._decrease_size(friendly_damage)

func _on_timer_timeout() -> void:
	queue_free()
