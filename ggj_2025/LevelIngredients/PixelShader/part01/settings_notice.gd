extends Node3D


func _ready() -> void:
	var override: String = ProjectSettings.get_setting("application/config/project_settings_override")
	if override != "":
		var lbl := Label.new()
		lbl.text = "Hey, don't override project settings for part01 (see README.md)"
		lbl.set_anchors_preset(Control.PRESET_FULL_RECT)
		lbl.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		lbl.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
		self.add_child(lbl)
