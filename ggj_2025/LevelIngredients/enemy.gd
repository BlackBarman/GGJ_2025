extends CharacterBody3D

var speed = 25
var nav_speed = 1.5
var bubble_chase = false
var bubble = null
@onready var nav_agent = $NavigationAgent3D


func _physics_process(delta: float) -> void:	
	if nav_agent.is_target_reachable():
		return
		
	var current_location = global_transform.origin
	var next_location = nav_agent.target_position
	var new_velocity = (next_location - current_location).normalized() *nav_speed
	velocity = new_velocity
	move_and_slide()
	
	
func update_target_location(target_location):
	nav_agent.target_position=target_location


func _on_detection_collider_body_entered(body: Node3D) -> void:
	bubble = body 
	bubble_chase = true


func _on_detection_collider_body_exited(body: Node3D) -> void:
	bubble = null 
	bubble_chase = false
