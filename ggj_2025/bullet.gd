extends Node3D
class_name BaseBullet

@export var bullet_speed : float
@export var friendly_damage : float = 0.3

var bullet_dir : Vector3


func _ready() -> void:
	%Timer.start()

func _process(delta: float) -> void:
	global_position += bullet_dir * bullet_speed * delta

func _on_visible_on_screen_notifier_3d_screen_exited() -> void:
	queue_free()

func _on_area_3d_body_entered(body):
	if body.is_in_group("EnemyGroup"):
		body._die()
		queue_free()
	elif body.get_parent().is_in_group("BubbleBaseGroup"):
		body.get_parent()._decrease_size(friendly_damage)
	elif body.get_parent().is_in_group("BubbleBullet"):
		body.get_parent()._explode()
		queue_free()



func _on_timer_timeout() -> void:
	queue_free()


func _on_area_3d_area_entered(area: Area3D) -> void:
	if area.is_in_group("BubbleBaseGroup"):
		print("ciao")
	pass # Replace with function body.
