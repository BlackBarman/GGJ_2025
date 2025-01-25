extends Node3D

@export var bubble_bullet : PackedScene
@export var bubble_spawn_point : Node3D
@export var bubble_spawn_point_2 : Node3D
@export var max_bubble_bullets : int = 3
var current_bubble_bullets : int = 0

var can_shoot = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.BubbleBulletPopped.connect(_bubble_bullet_popped)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_launch_bubble") && can_shoot && current_bubble_bullets < max_bubble_bullets:
		var new_bubble_bullet = bubble_bullet.instantiate() as BubbleBullet
		new_bubble_bullet.global_position = bubble_spawn_point.global_position
		
		new_bubble_bullet.bullet_dir = (bubble_spawn_point.global_position - bubble_spawn_point_2.global_position).normalized()
		new_bubble_bullet.bullet_dir.y = 0
		get_tree().root.add_child(new_bubble_bullet)
		can_shoot = false
		current_bubble_bullets += 1
		$Cooldown.start()


func _on_cooldown_timeout() -> void:
	can_shoot = true 

func _bubble_bullet_popped():
	current_bubble_bullets -= 1
