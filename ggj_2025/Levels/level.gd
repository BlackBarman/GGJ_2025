extends Node3D


class_name Level

var game_over = false
var score : float = 0.0
@export var base_score_per_second = 10.0
@export var bubble_base_modifier = 1.0
@export var bubble_bases : Array[BubbleBase]
@export var enemy_score_popup : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.BubbleBasePopped.connect(_bubble_base_popped)
	SignalBus.PlayerDied.connect(_player_died)
	SignalBus.EnemyDiedInExplosion.connect(_score_enemy_exploded)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if game_over == false:
		_add_score(delta)


func _add_score(delta :float) -> void:
	score += (base_score_per_second*_calculate_bubble_score_modifier()*delta) 


func _bubble_base_popped(bubble_base: BubbleBase):
	bubble_bases.erase(bubble_base)
	if bubble_bases.size() <= 0:
		game_over = true
		$UserInterface._reveal_game_over_screen()

func _player_died():
	game_over = true
	$UserInterface._reveal_game_over_screen()

func _calculate_bubble_score_modifier() -> float:
	var basic_bubble_base_modifier : float = 1
	for i in bubble_bases:
		basic_bubble_base_modifier *= i.scale.x
	return basic_bubble_base_modifier*bubble_base_modifier

func _score_enemy_exploded(enemy_base_score : int, enemy_position : Vector3):
	score += enemy_base_score*_calculate_bubble_score_modifier()
	var pop_up = enemy_score_popup.instantiate() as EnemyScorePopUp
	$UserInterface.add_child(pop_up)
	pop_up._set_score(enemy_base_score*_calculate_bubble_score_modifier())
	pop_up.world_position = enemy_position
	
