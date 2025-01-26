extends Node3D

@export var bullet : PackedScene

@export var bullet_parent : Node3D

@export var bullet_spawn_pos : Node3D

@onready var front_spawn = %bullet_spawn_point
@onready var back_spawn  = %bullet_spawn_point2

var can_shoot = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_pressed("shoot"):
		call_deferred("shoot")
		
		



func shoot():
	if can_shoot == true:
		var bull = bullet.instantiate() as BaseBullet
		get_tree().root.add_child(bull)
		
		bull.global_position = bullet_spawn_pos.global_position
		bull.bullet_dir = (front_spawn.global_position - back_spawn.global_position).normalized()
		bull.bullet_dir.y = 0
		AudioManager.Gunshot.play()
		AudioManager.Gunshot.pitch_scale = 1 + AudioManager.rng.randf_range(-0.1, 0.1)
		can_shoot = false
		$Timer.start()
		


func _on_timer_timeout() -> void:
	can_shoot = true
