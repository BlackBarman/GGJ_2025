extends Node

##this is a global, in your scripts simply call the global class,
##the name of the audio file and add. play 
## ie : AudioManager.BuildTower.play() (from any script)

@onready var Gunshot = $Gunshot
@onready var SmallBoom = $SmallBoom
@onready var PlayerHurt = $PlayerHurt
@onready var PlayerDeath = $PlayerDeath
@onready var BubbleUp = $BubbleUp
@onready var BigExplosion = $BigExplosion
