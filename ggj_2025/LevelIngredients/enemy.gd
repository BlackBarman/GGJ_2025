extends CharacterBody3D
var damage_to_bubble = 10
var nav_speed = 1
var target_bubble = null
@onready var nav_agent = $NavigationAgent3D

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

func _physics_process(delta: float) -> void:	
	if nav_agent.is_target_reachable():
		return
	else:
		_get_new_bubble()
		
	if target_bubble ==null:
		_get_new_bubble()
		return
	
	var bubble_size = target_bubble.get_global_transform().basis.x
	var current_location = global_transform.origin
	var next_location = nav_agent.target_position 
	look_at(next_location)
	rotation.x =0
	rotation.z =0
	var distance_to_bubble = nav_agent.distance_to_target()
	
	if distance_to_bubble - 0.7 < bubble_size.x:
		velocity = Vector3(0,0,0)  
		target_bubble._decrease_size(delta/damage_to_bubble)
	else:
		var new_velocity = (next_location - current_location).normalized() *nav_speed
		velocity = new_velocity 
		move_and_slide()
	
func update_target_location(target_location):
	nav_agent.target_position=target_location
