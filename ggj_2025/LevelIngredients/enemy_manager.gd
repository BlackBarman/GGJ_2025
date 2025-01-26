extends Node3D

@export var enemy_scene: PackedScene
@export var chase_enemy_scene: PackedScene

@export var enemy_spawn_time = 1
@export var enemies_to_spawn = 1;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Timer.wait_time = enemy_spawn_time
	$Timer.start()
	$IncreaseTimer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_timer_timeout() -> void:
	var enemies = get_tree().get_nodes_in_group("EnemyGroup")
	
	if enemies.size() < 120:
		for n in enemies_to_spawn:
			var enemy = null
			var randInt = randi_range(0, 100)
			if(randInt >70):
				enemy= chase_enemy_scene.instantiate()
			else:
				enemy= enemy_scene.instantiate()
			var path_length = $SpawnLocation.curve.get_baked_length()
			var offset = randf_range(0.0, path_length)
			var enemy_spawn_location = $SpawnLocation.curve.sample_baked(offset)
			add_child(enemy)

			enemy.global_position = global_transform.basis * enemy_spawn_location


func _on_increase_timer_timeout() -> void:
	enemies_to_spawn += 1
