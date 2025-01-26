extends Node3D

class_name BubbleBullet

var bullet_dir : Vector3
@export var max_size : float = 3.0
@export var size_change_speed : float = 1.0
@export var explosion_max_size : float = 3.0
@export var explosion_growth_speed : float = 10
@export var explosion_enemy_damage : float = 4
@export var explosion_player_damage : int = 3
@export var explosion_base_bubble_damage : float = 0.4

var exploding = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#expands
	if scale.x < max_size && exploding == false:
		scale.x += (size_change_speed * delta)
		scale.y += (size_change_speed * delta)
		scale.z += (size_change_speed * delta)
	
	if exploding == true:
		if $ExplosionArea.scale.x < explosion_max_size:
			$ExplosionArea.scale.x += (explosion_growth_speed * delta)
			$ExplosionArea.scale.y += (explosion_growth_speed * delta)
			$ExplosionArea.scale.z += (explosion_growth_speed * delta)
		else:
			queue_free()


func _explode():
	if exploding == false:
		exploding = true
		$ExplosionArea/ExplosionMesh3D.visible = true
		AudioManager.BigExplosion
		SignalBus.emit_signal("BubbleBulletPopped")


func _on_explosion_area_area_entered(area: Area3D) -> void:
	if area.is_in_group("EnemyCollisionGroup"):
		area.get_owner()._die()
	if area.is_in_group("BubbleBaseGroup"):
		area.get_owner()._decrease_size(explosion_base_bubble_damage)
