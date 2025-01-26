extends Control

class_name EnemyScorePopUp

var world_position = Vector3(0,0,0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	var cam := get_viewport().get_camera_3d()
	var pos_2d := cam.unproject_position(world_position)
	global_position = pos_2d


func _on_timer_timeout() -> void:
	queue_free()

func _set_score(score : int):
	$Label.text = "+" + str(score)
	
