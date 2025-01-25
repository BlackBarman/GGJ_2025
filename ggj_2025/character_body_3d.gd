extends CharacterBody3D


var lives = 10
const SPEED = 5.0
const JUMP_VELOCITY = 4.5

@export var camera  : Camera3D

func _process(_delta: float) -> void:
	
	var mouse_pos = get_viewport().get_mouse_position()
	var ray_origin =  camera.project_ray_origin(mouse_pos)
	var ray_dir = camera.project_ray_normal(mouse_pos) * 500
	var line_trace = PhysicsRayQueryParameters3D.create(ray_origin, ray_dir) 
	
	line_trace.collide_with_bodies = true
	
	var world_space = get_world_3d().direct_space_state
	var line_trace_result = world_space.intersect_ray(line_trace) 
	
	
	if not line_trace_result.is_empty():
		%body.look_at(line_trace_result.position) # can also put an offset on the y axis
		%body.rotation.z = 0
		%body.rotation.x = 0
	
	pass


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector( "ui_down", "ui_up","ui_left", "ui_right",)
	var direction := (Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("EnemyGroup"):
		lives -= 1
		print("ahiwa che male! vite rimaste: "+ str(lives))
		if lives == 0 :
			queue_free()
	pass # Replace with function body.


func _on_area_3d_area_entered(area: Area3D) -> void:
	if area.is_in_group("EnemyCollisionGroup"):
		lives -= 1
		print("ahiwa che male! vite rimaste: "+ str(lives))
	elif area.is_in_group("ExplosionGroup"):
		lives -= area.get_owner().explosion_player_damage
	if lives <= 0 :
		SignalBus.PlayerDied.emit()
		queue_free()
	pass # Replace with function body.
