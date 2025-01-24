extends Node3D


class_name Level

var game_over = false
var score : float = 0.0
@export var base_score_per_second = 10.0
@export var bubble_base_modifier = 1.0
@export var bubble_bases : Array[BubbleBase]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if game_over == false:
		_add_score(delta)

func _add_score(delta :float) -> void:
	var basic_bubble_base_modifier : float
	for i in bubble_bases:
		basic_bubble_base_modifier += i.scale.x
	score += (base_score_per_second*basic_bubble_base_modifier*bubble_base_modifier*delta) 
