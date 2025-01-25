extends Node3D


func _ready() -> void:
	var override: String = ProjectSettings.get_setting("application/config/project_settings_override")
	if override == "":
		var lbl := Label.new()
		lbl.text = "Hey, maybe override project settings for part02 and part03 (see README.md)"
		lbl.set_anchors_preset(Control.PRESET_FULL_RECT)
		lbl.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
		self.add_child(lbl)
