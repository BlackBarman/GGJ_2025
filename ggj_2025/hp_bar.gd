extends ProgressBar


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.PlayerHealthChanged.connect(_update_player_health)


func _update_player_health(new_health_value : int, max_health_value : int):
	value = (max_value*new_health_value)/max_health_value
