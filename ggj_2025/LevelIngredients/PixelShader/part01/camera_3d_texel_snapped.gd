class_name Camera3DTexelSnapped
extends Camera3D

@export var snap := true

@onready var _prev_rotation := global_rotation
@onready var _snap_space := global_transform


func _process(_delta: float) -> void:
	# rotation changes the snap space
	if global_rotation != _prev_rotation:
		_prev_rotation = global_rotation
		_snap_space = global_transform
	var texel_size := size / 180.0
	# camera position in snap space
	var snap_space_position := global_position * _snap_space
	# snap!
	var snapped_snap_space_position := snap_space_position.snapped(Vector3.ONE * texel_size)
	# how much we snapped (in snap space)
	var snap_error := snapped_snap_space_position - snap_space_position
	if snap:
		# apply camera offset as to not affect the actual transform
		h_offset = snap_error.x
		v_offset = snap_error.y
