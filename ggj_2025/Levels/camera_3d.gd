extends Camera3D


@export var character : CharacterBody3D
@export var speed : float = 3.0
@export var main_level : Level

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if main_level.game_over == false:
		
		var new_position = global_position.lerp(character.global_position, speed*delta)
		global_position.x = new_position.x
		global_position.z = new_position.z
