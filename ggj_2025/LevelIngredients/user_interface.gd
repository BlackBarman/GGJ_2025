extends Control

@export var main_level : Level

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if main_level.game_over == false:
		_update_score()
		_update_progress_bars() 

func _update_score() -> void:
	var cleaned_score = int(main_level.score)
	$VBoxContainer/Score.text = "SCORE: " + str(cleaned_score)
	pass

func _update_progress_bars() -> void:
	for i in main_level.bubble_bases:
		pass
	$VBoxContainer/VBoxContainer/BubbleBase1Size.value = main_level.bubble_bases[0].scale.x*100
	$VBoxContainer/VBoxContainer2/BubbleBase2Size.value = main_level.bubble_bases[1].scale.x*100
	$VBoxContainer/VBoxContainer3/BubbleBase3Size.value = main_level.bubble_bases[2].scale.x*100
