extends Camera3D


@export var character : CharacterBody3D
@export var speed : float = 15.0
@export var main_level : Level

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if main_level.game_over == false:
		var hor_position = Vector2(global_position.x,global_position.z)
		var hor_target = Vector2(character.global_position.x, character.global_position.z)
		print("target: ", hor_target)
		#hor_position.lerp(hor_target, speed)
		hor_position = hor_target
		print("current position: ", hor_position)
		global_position.x = hor_position.x
		global_position.z = hor_position.y
