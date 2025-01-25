extends Node3D

@export var move_speed: float = 4.0

@export_range(0, 50) var orbit_speed: float = 4.0
var _target_orbit := rotation.y

@export var circular_radius: float = 0.0
@export var circular_speed: float = 0.2
var _circ_angle: float = 0

@onready var cam: Camera3D = $Camera3D


func _process(delta: float) -> void:
	# movement
	var input_vec := Input.get_vector("cam_left", "cam_right", "cam_back", "cam_forward")
	# basis without pitch, so pretty much the yaw; who rolls a camera??
	var yaw := Basis(basis.x, Vector3.UP, basis.z).orthonormalized()
	# scaling forward so pitched ortho camera speed seems constant as if 2D
	var move_vec := yaw * Vector3(input_vec.x, 0, input_vec.y / sin(rotation.x))
	position += move_vec * move_speed * delta
	
	# orbit
	if Input.is_action_just_pressed("cam_orbit_right"):
		_target_orbit += TAU/8
	if Input.is_action_just_pressed("cam_orbit_left"):
		_target_orbit -= TAU/8
	rotation.y = lerpf(rotation.y, _target_orbit, 1.0 - 2.0 ** (-4.0 * delta * orbit_speed))
	if absf(rotation.y - _target_orbit) < 0.02:
		rotation.y = _target_orbit
	
	# circles
	_circ_angle -= TAU * circular_speed * delta
	cam.position.x = cos(_circ_angle) * circular_radius
	cam.position.y = sin(_circ_angle) * circular_radius
