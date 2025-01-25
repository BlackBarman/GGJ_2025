extends Node3D
class_name BaseBullet

@export var bullet_speed : float

var bullet_dir : Vector3


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += bullet_dir * bullet_speed * delta
	pass
