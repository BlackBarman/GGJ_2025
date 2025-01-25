extends Area3D
class_name HealthComponent


func _on_body_entered(body):
	if body.is_in_group("PlayerBullet"):
		print("the hurtbox is detecting a bullet")
		get_parent().queue_free()
	pass # Replace with function body.
