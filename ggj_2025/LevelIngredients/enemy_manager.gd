extends Node3D

@export var enemy_scene: PackedScene

@export var enemy_spawn_time = 1


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Timer.wait_time = enemy_spawn_time
	$Timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_timer_timeout() -> void:
	var enemy = enemy_scene.instantiate()
	var path_length = $SpawnLocation.curve.get_baked_length()
	var offset = randf_range(0.0, path_length)
	var enemy_spawn_location = $SpawnLocation.curve.sample_baked(offset)

	enemy.position = enemy_spawn_location
	add_child(enemy)
