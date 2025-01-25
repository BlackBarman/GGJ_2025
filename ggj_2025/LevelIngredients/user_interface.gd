extends Control

@export var main_level : Level
@export var bubble_base_1 : BubbleBase
@export var bubble_base_2 : BubbleBase
@export var bubble_base_3 : BubbleBase

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$GameOverScreen.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if main_level.game_over == false:
		_update_score()
		_update_progress_bars() 

func _update_score() -> void:
	var cleaned_score = int(main_level.score)
	$VBoxContainer/Score.text = "SCORE: " + str(cleaned_score)

func _update_progress_bars() -> void:
	if is_instance_valid(bubble_base_1):
		$VBoxContainer/VBoxContainer/BubbleBase1Size.value = main_level.bubble_bases[0].scale.x*100
	if is_instance_valid(bubble_base_2):
		$VBoxContainer/VBoxContainer2/BubbleBase2Size.value = main_level.bubble_bases[1].scale.x*100
	if is_instance_valid(bubble_base_3):
		$VBoxContainer/VBoxContainer3/BubbleBase3Size.value = main_level.bubble_bases[2].scale.x*100


func _reveal_game_over_screen() -> void:
	$GameOverScreen.visible = true
	var cleaned_score = int(main_level.score)
	$GameOverScreen/VBoxContainer/FinalScoreLabel.text = "FINAL SCORE: " + str(cleaned_score)


func _on_try_again_button_pressed() -> void:
	get_tree().reload_current_scene()
