extends CharacterBody3D

var max_lives = 10
var lives = max_lives:
	get:
		return lives
	set(value):
		lives = value
		SignalBus.PlayerHealthChanged.emit(value, max_lives)

const SPEED = 10.0
const JUMP_VELOCITY = 4.5

@export var camera  : Camera3D
@export var cast_camera  : Camera3D

func _process(_delta: float) -> void:
	
	#var mouse_pos = get_viewport().get_mouse_position()
	#var ray_origin =  camera.project_ray_origin(mouse_pos)
	#var ray_dir = camera.project_ray_normal(mouse_pos) * 500
	#var line_trace = PhysicsRayQueryParameters3D.create(ray_origin, ray_dir) 
	#
	#line_trace.collide_with_bodies = true
	
	var ray_length = 100000
	var world_space = get_world_3d().direct_space_state
	var mouse_position = cast_camera.get_viewport().get_mouse_position()
	
	var origin = cast_camera.project_ray_origin(mouse_position)
	var end =origin+cast_camera.project_ray_normal(mouse_position)* ray_length
	var params = PhysicsRayQueryParameters3D.new()
	params.from = origin
	params.to = end
	params.collision_mask =9
	var intersection = world_space.intersect_ray(params)
	
	if not intersection .is_empty():
		%body.look_at(Vector3(intersection.position.x,global_position.y,intersection.position.z)) # can also put an offset on the y axis
		#//%body.rotation.z = 0
		#//%body.rotation.x = 0


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

#func _on_area_3d_body_entered(body: Node3D) -> void:
	#if body.is_in_group("EnemyGroup"):
		#lives -= 1
		#print("ahiwa che male! vite rimaste: "+ str(lives))
		#if lives == 0 :
			#queue_free()


func _on_area_3d_area_entered(area: Area3D) -> void:
	if area.is_in_group("EnemyCollisionGroup"):
		lives -= 1
		AudioManager.PlayerHurt.play()
		print("ahiwa che male! vite rimaste: "+ str(lives))
	elif area.is_in_group("ExplosionGroup"):
		AudioManager.PlayerHurt.play()
		lives -= area.get_owner().explosion_player_damage
	if lives <= 0 :
		AudioManager.PlayerDeath.play()
		SignalBus.PlayerDied.emit()
		queue_free()
