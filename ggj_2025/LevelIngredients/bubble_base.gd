extends Node3D


class_name BubbleBase


@export var size_change_speed : float = 0.1
@export var max_size : float = 3.0
@export var min_size : float = 0.4

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_increase_size(delta)


func _increase_size(delta: float) -> void: 
	if scale.x < max_size:
		scale.x += (size_change_speed * delta)
		scale.y += (size_change_speed * delta)
		scale.z += (size_change_speed * delta)


func _decrease_size(damage : float) -> void:
	scale.x -= damage
	scale.y -= damage
	scale.z -= damage
	if scale.x <= min_size:
		_die()


func _die() -> void:
	SignalBus.BubbleBasePopped.emit(self)
	queue_free()
