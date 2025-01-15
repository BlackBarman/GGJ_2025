extends Node

#This global script manages the high level transitions withing the game:
#entering the main menu, going from the menu to the game, entering a battle,
#entering a win screen, and so on. 
#Therefore, if you need to "change level", use the func _change_scene
#it makes sure everything is loaded and unloaded properly without fucking anything up


#keeping these refs in a global variable should avoid any dependency issues
#maybe, idk, I don't wanna deal with it
var main_menu_ref = "" #to fill later
var gym_level_ref = "" #to fill later

signal scene_changed
signal scene_unloaded

func  _ready() -> void:
	#APPARENTLY, even a global script can be paused, so you need to specify that it's always on
	process_mode = Node.PROCESS_MODE_ALWAYS
	randomize()

#changes both the scene and the game state
func _change_scene(old_scene : Node, new_scene : String):
	if ResourceLoader.exists(new_scene):
		
		#reset and unload previous scene
		get_tree().paused = false
		old_scene.queue_free()
		scene_unloaded.emit()
		
		#load new one
		var scene = ResourceLoader.load(new_scene)
		var scene_instance = scene.instantiate()
		get_tree().root.add_child(scene_instance)
		scene_changed.emit()
		
	else:
		print("the path: ", new_scene, " isn't valid.")
