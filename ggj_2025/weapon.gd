extends Node3D

@export var bullet : PackedScene

@export var bullet_parent : Node3D

@export var bullet_spawn_pos : Node3D


#Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_pressed("shoot"):
		var bull = bullet.instantiate() as BaseBullet
		bullet_parent.add_child(bull)
		bull.position = bullet_spawn_pos.position
		
		bull.bullet_dir = %bullet_spawn_point.position
		
	pass
