extends CharacterBody3D
@export var damage_to_bubble = 10
@export var nav_speed = 2
@export var nav_speed_player = 5
@export var follow_player = false
@export var enemy_base_score : float = 100
var target_bubble = null
@onready var nav_agent = $NavigationAgent3D
var following_player=false

func _ready() -> void:
	_get_new_bubble()

func _get_new_bubble():
	var bubbles = get_tree().get_nodes_in_group("BubbleBaseGroup")
	var closest_distance = 10000000
	var closest_bubble = null
	
	for b in bubbles:
		var dis = global_position.distance_to(b.global_position)
		if dis < closest_distance:
			closest_distance = dis
			closest_bubble = b
	
	if closest_bubble != null:
		target_bubble = closest_bubble
		update_target_location(target_bubble.position)
	else:
		target_bubble =null


func _process(delta: float) -> void:
	if $Area3D.has_overlapping_areas():
		for i in $Area3D.get_overlapping_areas() :
			if i.is_in_group("PlayerBullet"):
				queue_free()
			pass

func _physics_process(delta: float) -> void:	
	if nav_agent.is_target_reachable():
		return
	else:
		if !following_player:
			_get_new_bubble()
		
	if target_bubble ==null:
		_get_new_bubble()
		return
		
	if !following_player || !follow_player:
		var bubble_size = target_bubble.get_global_transform().basis.x
		var current_location = global_transform.origin
		var next_location = nav_agent.target_position 
		look_at(next_location)
		rotation.x =0
		rotation.z =0
		var distance_to_bubble = nav_agent.distance_to_target()
		
		if distance_to_bubble - 0.9 < bubble_size.x:
			velocity = Vector3(0,0,0)  
			target_bubble._decrease_size(delta/damage_to_bubble)
		else:
			var new_velocity = (next_location - current_location).normalized() *nav_speed
			velocity = new_velocity 
			move_and_slide()
	else:
		update_target_location(target_bubble.global_position)
		var current_location = global_transform.origin
		var next_location = nav_agent.target_position 
		look_at(next_location)
		var new_velocity = (next_location - current_location).normalized() *nav_speed_player
		velocity = new_velocity 
		move_and_slide()
	
func update_target_location(target_location):
	nav_agent.target_position=target_location


func _on_detection_collider_body_entered(body: Node3D) -> void:
	if follow_player:
		if  body.name == "CharacterBody3D": 
			following_player =true
			target_bubble =body
			update_target_location(body.global_position)


func _die():
	AudioManager.SmallBoom.play()
	queue_free()


func _on_area_3d_area_exited(area: Area3D) -> void:
	if area.is_in_group("PlayerBullet"):
		queue_free()
	pass # Replace with function body.
