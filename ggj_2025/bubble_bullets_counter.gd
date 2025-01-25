extends Label

var bubble_bullets : int = 0
var max_bullets : int = 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.BubbleBulletSent.connect(_increase_counter)
	SignalBus.BubbleBulletPopped.connect(_decrease_counter)
	SignalBus.MaxBubbleBulletsSet.connect(_set_max_bullets)


func _increase_counter():
	bubble_bullets += 1
	text = "Bubble Bullets: " + str(bubble_bullets) + "/" + str(max_bullets)

func _decrease_counter():
	bubble_bullets -= 1
	text = "Bubble Bullets: " + str(bubble_bullets) + "/" + str(max_bullets)


func _set_max_bullets(max_bubble_bullets: int):
	max_bullets = max_bubble_bullets
	text = "Bubble Bullets: " + str(bubble_bullets) + "/" + str(max_bullets)
