extends ColorRect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	$"../ControlsExplBackground".visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel") == true:
		if get_tree().paused == false:
			get_tree().paused = true
			visible = true
		else:
			visible = false
			get_tree().paused = false


func _on_resume_button_pressed() -> void:
	$"../ControlsExplBackground".visible = false
	get_tree().paused = false
	visible = false


func _on_restart_button_pressed() -> void:
	$"../ControlsExplBackground".visible = false
	LevelChanger._reload_level()


func _on_show_controls_button_pressed() -> void:
	if $"../ControlsExplBackground".visible == false:
		$"../ControlsExplBackground".visible = true
	else:
		$"../ControlsExplBackground".visible = false
