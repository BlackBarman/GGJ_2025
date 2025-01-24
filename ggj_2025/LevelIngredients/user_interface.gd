extends Control

@export var main_level : Level

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if main_level.game_over == false:
		_update_score()

func _update_score() -> void:
	var cleaned_score = int(main_level.score)
	$Label.text = "SCORE: " + str(cleaned_score)
	pass
