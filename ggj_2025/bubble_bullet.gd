extends Node3D

class_name BubbleBullet

var bullet_dir : Vector3
@export var max_size : float = 3.0
@export var size_change_speed : float = 1.0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#expands
	if scale.x < max_size:
		scale.x += (size_change_speed * delta)
		scale.y += (size_change_speed * delta)
		scale.z += (size_change_speed * delta)
	
