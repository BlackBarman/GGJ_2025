extends Node3D

@export var bullet : PackedScene

@export var bullet_parent : Node3D

@export var bullet_spawn_pos : Node3D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_pressed("shoot"):
		var bull = bullet.instantiate() as BaseBullet
		bull.global_position = bullet_spawn_pos.global_position
		
		bull.bullet_dir = (%bullet_spawn_point.global_position - %bullet_spawn_point2.global_position).normalized()
		bull.bullet_dir.y = 0
		get_tree().root.add_child(bull)
