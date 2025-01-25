extends Area3D
class_name HealthComponent


func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("PlayerBullet"):
		get_parent().queue_free()
	pass # Replace with function body.
