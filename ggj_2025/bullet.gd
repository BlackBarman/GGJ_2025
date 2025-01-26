extends Node3D
class_name BaseBullet

@export var bullet_speed : float = 30
@export var friendly_damage : float = 0.3
@export var acceleration : float  = 3
var bullet_dir : Vector3



func _ready() -> void:
	%Timer.start()
	if $Area3D.has_overlapping_areas():
		print("i am overlapping at born")
		kill_overlapping_enemies()
		pass

func kill_overlapping_enemies():
	var temp: Array[Area3D]= $Area3D.get_overlapping_areas() 
	for i in temp:
		if i.is_in_group("EnemyCollisionGroup"):
			i.queue_free()
			pass
		pass

func _process(delta: float) -> void:
	if $Area3D.has_overlapping_areas():
		print("I am colliding with an area")
		kill_overlapping_enemies()
		pass

func _physics_process(delta: float) -> void:
	bullet_speed += acceleration * delta
	global_position += bullet_dir * bullet_speed * delta

func _on_visible_on_screen_notifier_3d_screen_exited() -> void:
	queue_free()

func _on_area_3d_body_entered(body):
	if body.is_in_group("EnemyGroup"):
		body._die()
		kill_overlapping_enemies()
		queue_free()
	elif body.get_parent().is_in_group("BubbleBaseGroup"):
		body.get_parent()._decrease_size(friendly_damage)
	elif body.get_parent().is_in_group("BubbleBullet"):
		body.get_parent()._explode()
		queue_free()



func _on_timer_timeout() -> void:
	queue_free()
